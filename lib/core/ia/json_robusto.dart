import 'dart:convert';

/// Extrae un objeto JSON del texto que devuelve un modelo de IA.
///
/// Aunque pidamos "SOLO JSON", los modelos a veces envuelven la respuesta
/// en fences de markdown (```json ... ```) o agregan texto alrededor.
/// Probamos tres estrategias, de la más simple a la más agresiva.
/// Devuelve null si nada funciona.
Map<String, dynamic>? extraerJsonRobusto(String texto) {
  // Intento 1: el texto ES el JSON.
  final directo = _decodificar(texto);
  if (directo != null) return directo;

  // Intento 2: sacar fences de markdown (```json ... ```).
  final sinFences = texto
      .replaceAll(RegExp(r'^```(json)?', multiLine: true), '')
      .replaceAll('```', '')
      .trim();
  final limpio = _decodificar(sinFences);
  if (limpio != null) return limpio;

  // Intento 3: quedarnos con lo que hay entre la primera { y la última }.
  final desde = texto.indexOf('{');
  final hasta = texto.lastIndexOf('}');
  if (desde >= 0 && hasta > desde) {
    return _decodificar(texto.substring(desde, hasta + 1));
  }
  return null;
}

Map<String, dynamic>? _decodificar(String texto) {
  try {
    final resultado = jsonDecode(texto);
    return resultado is Map<String, dynamic> ? resultado : null;
  } on FormatException {
    return null;
  }
}

/// La IA a veces manda números como int, double o String: convertimos todo.
double? numeroFlexible(Object? v) {
  if (v is num) return v.toDouble();
  if (v is String) return double.tryParse(v);
  return null;
}
