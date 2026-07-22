import 'package:drift/drift.dart';

import '../../../core/database/database.dart';

/// Repositorio de los hábitos diarios: agua, sueño y peso corporal.
/// Son tres entidades chicas con operaciones muy parecidas, por eso
/// viven juntas en un solo repositorio.
class HabitosRepository {
  HabitosRepository(this._db);

  final AppDatabase _db;

  (DateTime, DateTime) _rangoDia(DateTime dia) {
    final inicio = DateTime(dia.year, dia.month, dia.day);
    return (inicio, inicio.add(const Duration(days: 1)));
  }

  // ---------- Agua ----------

  /// Mililitros tomados en el día (0 si no hay registros).
  Stream<int> observarAguaDelDia(DateTime dia) {
    final (inicio, fin) = _rangoDia(dia);
    final consulta = _db.select(_db.waterEntries)
      ..where((t) =>
          t.fecha.isBiggerOrEqualValue(inicio) & t.fecha.isSmallerThanValue(fin));
    return consulta
        .watch()
        .map((filas) => filas.fold(0, (suma, f) => suma + f.ml));
  }

  Future<void> agregarVaso({int ml = 250}) {
    return _db.into(_db.waterEntries).insert(
        WaterEntriesCompanion.insert(fecha: DateTime.now(), ml: Value(ml)));
  }

  /// Deshace el último vaso del día (por si tocaste de más).
  Future<void> quitarUltimoVaso() async {
    final (inicio, fin) = _rangoDia(DateTime.now());
    final ultimo = await (_db.select(_db.waterEntries)
          ..where((t) =>
              t.fecha.isBiggerOrEqualValue(inicio) &
              t.fecha.isSmallerThanValue(fin))
          ..orderBy([(t) => OrderingTerm.desc(t.fecha)])
          ..limit(1))
        .getSingleOrNull();
    if (ultimo != null) {
      await (_db.delete(_db.waterEntries)
            ..where((t) => t.id.equals(ultimo.id)))
          .go();
    }
  }

  // ---------- Sueño ----------

  Stream<SleepEntry?> observarSuenoDelDia(DateTime dia) {
    final (inicio, fin) = _rangoDia(dia);
    return (_db.select(_db.sleepEntries)
          ..where((t) =>
              t.fecha.isBiggerOrEqualValue(inicio) &
              t.fecha.isSmallerThanValue(fin))
          ..limit(1))
        .watchSingleOrNull();
  }

  /// Guarda el sueño del día: si ya había un registro, lo reemplaza
  /// (un solo registro de sueño por día).
  Future<void> registrarSueno({
    required double horas,
    DateTime? acostarse,
    DateTime? levantarse,
  }) async {
    final hoy = DateTime.now();
    final existente = await observarSuenoDelDia(hoy).first;
    final companion = SleepEntriesCompanion.insert(
      fecha: hoy,
      horas: horas,
      horaAcostarse: Value(acostarse),
      horaLevantarse: Value(levantarse),
    );
    if (existente == null) {
      await _db.into(_db.sleepEntries).insert(companion);
    } else {
      await (_db.update(_db.sleepEntries)
            ..where((t) => t.id.equals(existente.id)))
          .write(companion);
    }
  }

  // ---------- Peso ----------

  /// Todos los registros de peso, del más viejo al más nuevo (para el
  /// gráfico de evolución).
  Stream<List<WeightEntry>> observarPesos() {
    return (_db.select(_db.weightEntries)
          ..orderBy([(t) => OrderingTerm.asc(t.fecha)]))
        .watch();
  }

  Future<void> registrarPeso(double pesoKg) async {
    await _db.into(_db.weightEntries).insert(
        WeightEntriesCompanion.insert(fecha: DateTime.now(), pesoKg: pesoKg));
    // Además actualizamos el peso del perfil: así los próximos cálculos
    // (calorías de ejercicio, objetivo de agua) usan el peso real.
    final perfil = await (_db.select(_db.userProfiles)..limit(1))
        .getSingleOrNull();
    if (perfil != null) {
      await (_db.update(_db.userProfiles)
            ..where((t) => t.id.equals(perfil.id)))
          .write(UserProfilesCompanion(pesoKg: Value(pesoKg)));
    }
  }

  Future<void> eliminarPeso(int id) {
    return (_db.delete(_db.weightEntries)..where((t) => t.id.equals(id))).go();
  }
}
