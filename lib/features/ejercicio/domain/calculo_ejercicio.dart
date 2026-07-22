/// Tipos de ejercicio con su valor MET y cálculo de calorías quemadas.
///
/// MET (Metabolic Equivalent of Task) es una medida estándar de intensidad:
/// 1 MET = energía en reposo. Caminar suave ≈ 3 MET, correr ≈ 10 MET.
enum TipoEjercicio {
  caminata('Caminata suave', 3.0),
  caminataRapida('Caminata rápida', 4.3),
  correr('Correr', 9.8),
  bicicleta('Bicicleta', 7.5),
  natacion('Natación', 7.0),
  futbol('Fútbol', 8.0),
  pesas('Pesas / gimnasio', 5.0),
  yoga('Yoga / stretching', 2.5),
  baile('Baile', 5.5),
  basquet('Básquet', 6.5),
  tenis('Tenis / pádel', 7.3),
  otro('Otro', 0);

  const TipoEjercicio(this.etiqueta, this.met);
  final String etiqueta;
  final double met;
}

/// Fórmula estándar de gasto calórico:
/// kcal por minuto = MET × 3.5 × peso(kg) / 200
double caloriasQuemadas({
  required double met,
  required double pesoKg,
  required int minutos,
}) {
  return met * 3.5 * pesoKg / 200 * minutos;
}
