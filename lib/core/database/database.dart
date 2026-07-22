import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../modelos/enums.dart';
import 'tables.dart';

// Este "part" es el archivo que genera build_runner con todo el código
// de acceso a datos (clases UserProfile, FoodEntry, companions, etc.).
part 'database.g.dart';

@DriftDatabase(
  tables: [
    UserProfiles,
    FoodEntries,
    ExerciseEntries,
    SleepEntries,
    WaterEntries,
    WeightEntries,
    Products,
  ],
)
class AppDatabase extends _$AppDatabase {
  /// El executor opcional permite inyectar una base en memoria en los tests.
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _abrirConexion());

  static QueryExecutor _abrirConexion() {
    // drift_flutter se encarga de elegir la ubicación correcta del archivo
    // .sqlite en cada plataforma (Android/iOS).
    return driftDatabase(name: 'nutritrack');
  }

  @override
  int get schemaVersion => 1;
}
