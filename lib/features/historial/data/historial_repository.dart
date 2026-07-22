import 'package:drift/drift.dart';

import '../../../core/database/database.dart';

/// Consultas por rango de fechas para el historial, los gráficos y la
/// exportación a CSV.
class HistorialRepository {
  HistorialRepository(this._db);

  final AppDatabase _db;

  Future<List<FoodEntry>> comidasEntre(DateTime desde, DateTime hasta) {
    return (_db.select(_db.foodEntries)
          ..where((t) =>
              t.fecha.isBiggerOrEqualValue(desde) &
              t.fecha.isSmallerThanValue(hasta))
          ..orderBy([(t) => OrderingTerm.asc(t.fecha)]))
        .get();
  }

  Future<List<SleepEntry>> suenoEntre(DateTime desde, DateTime hasta) {
    return (_db.select(_db.sleepEntries)
          ..where((t) =>
              t.fecha.isBiggerOrEqualValue(desde) &
              t.fecha.isSmallerThanValue(hasta))
          ..orderBy([(t) => OrderingTerm.asc(t.fecha)]))
        .get();
  }

  Future<List<WeightEntry>> pesosEntre(DateTime desde, DateTime hasta) {
    return (_db.select(_db.weightEntries)
          ..where((t) =>
              t.fecha.isBiggerOrEqualValue(desde) &
              t.fecha.isSmallerThanValue(hasta))
          ..orderBy([(t) => OrderingTerm.asc(t.fecha)]))
        .get();
  }

  // ---------- Para exportar TODO a CSV ----------

  Future<List<FoodEntry>> todasLasComidas() =>
      (_db.select(_db.foodEntries)
            ..orderBy([(t) => OrderingTerm.asc(t.fecha)]))
          .get();

  Future<List<ExerciseEntry>> todosLosEjercicios() =>
      (_db.select(_db.exerciseEntries)
            ..orderBy([(t) => OrderingTerm.asc(t.fecha)]))
          .get();

  Future<List<SleepEntry>> todoElSueno() =>
      (_db.select(_db.sleepEntries)
            ..orderBy([(t) => OrderingTerm.asc(t.fecha)]))
          .get();

  Future<List<WaterEntry>> todaElAgua() =>
      (_db.select(_db.waterEntries)
            ..orderBy([(t) => OrderingTerm.asc(t.fecha)]))
          .get();

  Future<List<WeightEntry>> todosLosPesos() =>
      (_db.select(_db.weightEntries)
            ..orderBy([(t) => OrderingTerm.asc(t.fecha)]))
          .get();

  // ---------- Borrar todo ----------

  /// Vacía todas las tablas (perfil incluido). Se usa desde Ajustes con
  /// doble confirmación.
  Future<void> borrarTodosLosDatos() async {
    await _db.transaction(() async {
      for (final tabla in _db.allTables) {
        await _db.delete(tabla).go();
      }
    });
  }
}
