import 'package:drift/drift.dart';

import '../../../core/database/database.dart';

/// Acceso a la tabla FoodEntries. Igual que con el perfil: las pantallas
/// pasan siempre por acá, nunca tocan Drift directo.
class ComidasRepository {
  ComidasRepository(this._db);

  final AppDatabase _db;

  /// Stream con las comidas de un día calendario (de 00:00 a 23:59).
  /// Emite de nuevo cada vez que se agrega/edita/borra algo.
  Stream<List<FoodEntry>> observarComidasDelDia(DateTime dia) {
    final inicio = DateTime(dia.year, dia.month, dia.day);
    final fin = inicio.add(const Duration(days: 1));
    return (_db.select(_db.foodEntries)
          ..where((t) =>
              t.fecha.isBiggerOrEqualValue(inicio) &
              t.fecha.isSmallerThanValue(fin))
          ..orderBy([(t) => OrderingTerm.asc(t.fecha)]))
        .watch();
  }

  Future<void> agregar(FoodEntriesCompanion comida) {
    return _db.into(_db.foodEntries).insert(comida);
  }

  Future<void> actualizar(int id, FoodEntriesCompanion comida) {
    return (_db.update(_db.foodEntries)..where((t) => t.id.equals(id)))
        .write(comida);
  }

  Future<void> eliminar(int id) {
    return (_db.delete(_db.foodEntries)..where((t) => t.id.equals(id))).go();
  }
}
