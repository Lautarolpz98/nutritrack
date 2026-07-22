import '../../../core/ia/json_robusto.dart';

/// Rutina de ejercicios sugerida por la IA para el día.
class EjercicioSugerido {
  const EjercicioSugerido({
    required this.nombre,
    required this.series,
    required this.repeticiones,
    required this.duracionMin,
    required this.descripcion,
  });

  final String nombre;
  // null significa "no aplica": una caminata no tiene series, una serie
  // de sentadillas no tiene duración.
  final int? series;
  final int? repeticiones;
  final int? duracionMin;
  final String descripcion;

  static EjercicioSugerido? desdeJson(Map<String, dynamic> json) {
    final nombre = json['nombre'];
    if (nombre is! String || nombre.trim().isEmpty) return null;
    return EjercicioSugerido(
      nombre: nombre.trim(),
      series: numeroFlexible(json['series'])?.round(),
      repeticiones: numeroFlexible(json['repeticiones'])?.round(),
      duracionMin: numeroFlexible(json['duracion_min'])?.round(),
      descripcion:
          json['descripcion'] is String ? json['descripcion'] as String : '',
    );
  }
}

class RutinaSugerida {
  const RutinaSugerida({required this.ejercicios, required this.notas});

  final List<EjercicioSugerido> ejercicios;
  final String notas;

  static RutinaSugerida? desdeTexto(String texto) {
    final json = extraerJsonRobusto(texto);
    if (json == null) return null;

    final crudos = json['ejercicios'];
    final ejercicios = <EjercicioSugerido>[];
    if (crudos is List) {
      for (final crudo in crudos) {
        if (crudo is Map<String, dynamic>) {
          final e = EjercicioSugerido.desdeJson(crudo);
          if (e != null) ejercicios.add(e);
        }
      }
    }
    if (ejercicios.isEmpty) return null; // una rutina vacía no es rutina

    return RutinaSugerida(
      ejercicios: ejercicios,
      notas: json['notas'] is String ? json['notas'] as String : '',
    );
  }
}
