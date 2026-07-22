import 'package:drift/drift.dart';

import '../../../core/database/database.dart';

class EjercicioRepository {
  EjercicioRepository(this._db);

  final AppDatabase _db;

  Stream<List<ExerciseEntry>> observarDelDia(DateTime dia) {
    final inicio = DateTime(dia.year, dia.month, dia.day);
    final fin = inicio.add(const Duration(days: 1));
    return (_db.select(_db.exerciseEntries)
          ..where((t) =>
              t.fecha.isBiggerOrEqualValue(inicio) &
              t.fecha.isSmallerThanValue(fin))
          ..orderBy([(t) => OrderingTerm.asc(t.fecha)]))
        .watch();
  }

  Future<void> agregar(ExerciseEntriesCompanion ejercicio) {
    return _db.into(_db.exerciseEntries).insert(ejercicio);
  }

  Future<void> eliminar(int id) {
    return (_db.delete(_db.exerciseEntries)..where((t) => t.id.equals(id)))
        .go();
  }

  /// Historial de los últimos 7 días, resumido como texto para dárselo
  /// a la IA cuando pide una rutina.
  Future<String> resumen7Dias() async {
    final desde = DateTime.now().subtract(const Duration(days: 7));
    final entradas = await (_db.select(_db.exerciseEntries)
          ..where((t) => t.fecha.isBiggerOrEqualValue(desde))
          ..orderBy([(t) => OrderingTerm.desc(t.fecha)]))
        .get();

    if (entradas.isEmpty) return 'Sin registros de ejercicio.';
    return entradas
        .map((e) => '- ${e.fecha.day}/${e.fecha.month}: ${e.tipo}, '
            '${e.duracionMin} min (~${e.caloriasQuemadas.round()} kcal)')
        .join('\n');
  }
}
