/// Lógica pura del contador de pasos.
///
/// El sensor de Android (TYPE_STEP_COUNTER) NO da "pasos de hoy": da un
/// contador acumulado desde el último reinicio del teléfono. Para saber
/// cuánto caminaste hoy hay que ir guardando el último valor leído y
/// sumar las diferencias.
library;

/// Resultado de procesar una lectura del sensor.
class EstadoPasos {
  const EstadoPasos({required this.pasosHoy, required this.ultimoValorSensor});

  final int pasosHoy;
  final int ultimoValorSensor;
}

/// Calcula el nuevo estado a partir de la lectura cruda del sensor.
///
/// Casos que maneja:
/// - Primera lectura del día (o primera vez): arranca en 0 y toma la
///   lectura como línea de base.
/// - Lectura normal: suma la diferencia con la lectura anterior.
/// - El teléfono se reinició (la lectura es MENOR que la anterior, porque
///   el contador del sensor vuelve a 0): suma la lectura completa.
EstadoPasos procesarLecturaSensor({
  required int lectura,
  int? pasosGuardadosHoy,
  int? ultimoValorGuardado,
}) {
  if (pasosGuardadosHoy == null || ultimoValorGuardado == null) {
    // Primer registro del día: la línea de base es la lectura actual.
    return EstadoPasos(pasosHoy: 0, ultimoValorSensor: lectura);
  }
  if (lectura >= ultimoValorGuardado) {
    return EstadoPasos(
      pasosHoy: pasosGuardadosHoy + (lectura - ultimoValorGuardado),
      ultimoValorSensor: lectura,
    );
  }
  // El contador se reinició (reboot): todo lo leído es nuevo.
  return EstadoPasos(
    pasosHoy: pasosGuardadosHoy + lectura,
    ultimoValorSensor: lectura,
  );
}

/// Calorías estimadas por caminar: ~0.0005 kcal por paso por kg.
/// Ej: 10.000 pasos con 70 kg ≈ 350 kcal.
double caloriasPorPasos(int pasos, double pesoKg) => pasos * 0.0005 * pesoKg;
