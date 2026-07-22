import '../../../core/ia/json_robusto.dart';

/// Modelo del resultado del análisis de una foto de comida por la IA.
///
/// Los campos son mutables a propósito: la pantalla de revisión deja
/// que el usuario corrija cualquier valor antes de guardar.
class ItemDetectado {
  ItemDetectado({
    required this.nombre,
    required this.porcionEstimadaG,
    required this.calorias,
    required this.proteinasG,
    required this.carbohidratosG,
    required this.grasasG,
  });

  String nombre;
  double porcionEstimadaG;
  double calorias;
  double proteinasG;
  double carbohidratosG;
  double grasasG;

  static ItemDetectado? desdeJson(Map<String, dynamic> json) {
    final nombre = json['nombre'];
    final calorias = numeroFlexible(json['calorias']);
    // Sin nombre o sin calorías el item no sirve.
    if (nombre is! String || nombre.trim().isEmpty || calorias == null) {
      return null;
    }
    return ItemDetectado(
      nombre: nombre.trim(),
      porcionEstimadaG: numeroFlexible(json['porcion_estimada_g']) ?? 0,
      calorias: calorias,
      proteinasG: numeroFlexible(json['proteinas_g']) ?? 0,
      carbohidratosG: numeroFlexible(json['carbohidratos_g']) ?? 0,
      grasasG: numeroFlexible(json['grasas_g']) ?? 0,
    );
  }
}

class AnalisisFoto {
  AnalisisFoto({
    required this.items,
    required this.confianza,
    required this.notas,
  });

  final List<ItemDetectado> items;
  final String confianza; // "alta" | "media" | "baja"
  final String notas;

  /// Parsea el texto crudo que devuelve el modelo de IA usando el
  /// extractor robusto compartido. Devuelve null si no hay JSON válido.
  static AnalisisFoto? desdeTexto(String texto) {
    final json = extraerJsonRobusto(texto);
    if (json == null) return null;

    final itemsCrudos = json['items'];
    final items = <ItemDetectado>[];
    if (itemsCrudos is List) {
      for (final crudo in itemsCrudos) {
        if (crudo is Map<String, dynamic>) {
          final item = ItemDetectado.desdeJson(crudo);
          if (item != null) items.add(item);
        }
      }
    }

    final confianza = json['confianza'];
    return AnalisisFoto(
      items: items,
      confianza: confianza is String &&
              const ['alta', 'media', 'baja'].contains(confianza)
          ? confianza
          : 'baja',
      notas: json['notas'] is String ? json['notas'] as String : '',
    );
  }
}
