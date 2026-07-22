/// Enums compartidos por toda la app.
///
/// Los guardamos en un solo archivo porque los usan tanto la base de datos
/// (Drift los persiste por su nombre, ej: "masculino") como la lógica de
/// cálculo y las pantallas.
library;

enum Sexo {
  masculino('Masculino'),
  femenino('Femenino');

  const Sexo(this.etiqueta);
  final String etiqueta;
}

enum NivelActividad {
  // El "factor" es el multiplicador estándar de actividad física que se
  // aplica sobre la TMB para estimar el gasto calórico diario total (TDEE).
  sedentario('Sedentario (poco o nada de ejercicio)', 1.2),
  ligero('Ligero (ejercicio 1-3 días/semana)', 1.375),
  moderado('Moderado (ejercicio 3-5 días/semana)', 1.55),
  activo('Activo (ejercicio 6-7 días/semana)', 1.725),
  muyActivo('Muy activo (trabajo físico + ejercicio)', 1.9);

  const NivelActividad(this.etiqueta, this.factor);
  final String etiqueta;
  final double factor;
}

enum Objetivo {
  // El "ajuste" son las kcal que se suman/restan al gasto diario:
  // un déficit de ~500 kcal/día equivale a bajar ~0.5 kg por semana.
  bajar('Bajar de peso', -500),
  mantener('Mantener peso', 0),
  subir('Subir de peso', 300);

  const Objetivo(this.etiqueta, this.ajusteKcal);
  final String etiqueta;
  final int ajusteKcal;
}

enum MomentoComida {
  desayuno('Desayuno'),
  almuerzo('Almuerzo'),
  cena('Cena'),
  snack('Snack');

  const MomentoComida(this.etiqueta);
  final String etiqueta;
}

/// De dónde salió un registro de comida (para mostrarlo distinto en la UI
/// y saber si los datos son estimados por IA).
enum OrigenRegistro { manual, barcode, foto }
