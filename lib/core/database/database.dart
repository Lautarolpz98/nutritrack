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
    StepDays,
    Products,
  ],
)
class AppDatabase extends _$AppDatabase {
  /// [nombre] permite tener una base POR USUARIO (nutritrack, nutritrack_u2,
  /// nutritrack_u3). El executor opcional inyecta una base en memoria en
  /// los tests.
  AppDatabase({QueryExecutor? executor, String nombre = 'nutritrack'})
      : super(executor ?? _abrirConexion(nombre));

  static QueryExecutor _abrirConexion(String nombre) {
    // drift_flutter se encarga de elegir la ubicación correcta del archivo
    // .sqlite en cada plataforma (Android/iOS).
    return driftDatabase(name: nombre);
  }

  @override
  int get schemaVersion => 2;

  /// Migraciones: cuando un usuario actualiza la app y su base vieja tiene
  /// un esquema anterior, Drift ejecuta SOLO los cambios que faltan.
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, desde, hasta) async {
          if (desde < 2) {
            // v2: contador de pasos + objetivo de pasos en el perfil.
            await m.createTable(stepDays);
            await m.addColumn(userProfiles, userProfiles.objetivoPasos);
          }
        },
      );
}
