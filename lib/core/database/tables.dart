import 'package:drift/drift.dart';

import '../modelos/enums.dart';

/// Definición de TODAS las tablas de la app.
///
/// Drift genera el código SQL y las clases Dart a partir de estas
/// definiciones (por eso hay que correr build_runner cuando cambian).
/// Convención: cada clase = una tabla; cada getter = una columna.

/// Perfil del usuario. En la práctica va a haber una sola fila.
class UserProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withDefault(const Constant(''))();
  IntColumn get edad => integer()();
  TextColumn get sexo => textEnum<Sexo>()();
  RealColumn get pesoKg => real()();
  RealColumn get alturaCm => real()();
  TextColumn get nivelActividad => textEnum<NivelActividad>()();
  TextColumn get objetivo => textEnum<Objetivo>()();

  // Objetivos diarios. Se calculan en el onboarding pero el usuario
  // puede ajustarlos a mano, por eso se guardan y no se recalculan siempre.
  IntColumn get objetivoCalorias => integer()();
  RealColumn get objetivoProteinasG => real()();
  RealColumn get objetivoCarbohidratosG => real()();
  RealColumn get objetivoGrasasG => real()();
  IntColumn get objetivoAguaMl => integer()();
  RealColumn get objetivoSuenoHoras => real().withDefault(const Constant(8))();

  // Preferencias
  TextColumn get unidadPeso => text().withDefault(const Constant('kg'))();

  DateTimeColumn get actualizadoEn => dateTime().withDefault(currentDateAndTime)();
}

/// Cada comida registrada (manual, por barcode o por foto).
class FoodEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
  RealColumn get calorias => real()();
  RealColumn get proteinasG => real().withDefault(const Constant(0))();
  RealColumn get carbohidratosG => real().withDefault(const Constant(0))();
  RealColumn get grasasG => real().withDefault(const Constant(0))();
  RealColumn get porcionGramos => real().nullable()();
  TextColumn get momento => textEnum<MomentoComida>()();
  TextColumn get origen => textEnum<OrigenRegistro>()();
  TextColumn get barcode => text().nullable()();
  DateTimeColumn get fecha => dateTime()();
}

/// Actividad física registrada.
class ExerciseEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tipo => text()();
  IntColumn get duracionMin => integer()();
  RealColumn get caloriasQuemadas => real()();
  TextColumn get notas => text().nullable()();
  DateTimeColumn get fecha => dateTime()();
}

/// Registro de sueño: o bien horas directas, o acostarse/levantarse.
class SleepEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get fecha => dateTime()();
  RealColumn get horas => real()();
  DateTimeColumn get horaAcostarse => dateTime().nullable()();
  DateTimeColumn get horaLevantarse => dateTime().nullable()();
}

/// Cada fila = un vaso/toma de agua.
class WaterEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get fecha => dateTime()();
  IntColumn get ml => integer().withDefault(const Constant(250))();
}

/// Evolución del peso corporal.
class WeightEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get fecha => dateTime()();
  RealColumn get pesoKg => real()();
}

/// Cache de productos consultados en Open Food Facts, indexado por barcode.
/// Los valores nutricionales son POR 100 GRAMOS (así vienen de la API).
class Products extends Table {
  TextColumn get barcode => text()();
  TextColumn get nombre => text()();
  RealColumn get caloriasPor100g => real()();
  RealColumn get proteinasPor100g => real().withDefault(const Constant(0))();
  RealColumn get carbohidratosPor100g => real().withDefault(const Constant(0))();
  RealColumn get grasasPor100g => real().withDefault(const Constant(0))();
  DateTimeColumn get cacheadoEn => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {barcode};
}
