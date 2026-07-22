/// Modelo y parseo de un producto de Open Food Facts.
///
/// El parseo está separado del servicio HTTP a propósito: es una función
/// pura (JSON adentro → objeto afuera) y así se testea sin internet.
class ProductoOFF {
  const ProductoOFF({
    required this.barcode,
    required this.nombre,
    required this.caloriasPor100g,
    required this.proteinasPor100g,
    required this.carbohidratosPor100g,
    required this.grasasPor100g,
  });

  final String barcode;
  final String nombre;
  final double caloriasPor100g;
  final double proteinasPor100g;
  final double carbohidratosPor100g;
  final double grasasPor100g;

  /// Parsea la respuesta completa de la API v2 de Open Food Facts.
  /// Devuelve null si el producto no existe (status = 0) o si no tiene
  /// datos mínimos utilizables (nombre + calorías).
  static ProductoOFF? desdeRespuestaApi(
      Map<String, dynamic> json, String barcode) {
    // status 1 = encontrado, 0 = no existe en la base de OFF
    if (json['status'] != 1) return null;

    final producto = json['product'];
    if (producto is! Map<String, dynamic>) return null;

    // El nombre puede venir en varios campos según el país del producto.
    final nombre = _primerTextoNoVacio([
      producto['product_name_es'],
      producto['product_name'],
      producto['generic_name'],
    ]);
    if (nombre == null) return null;

    final nutrientes = producto['nutriments'];
    if (nutrientes is! Map<String, dynamic>) return null;

    final calorias = _comoDouble(nutrientes['energy-kcal_100g']);
    if (calorias == null) return null; // sin calorías el producto no sirve

    // La marca le da contexto al nombre ("Galletitas" → "Galletitas - Oreo")
    final marca = _primerTextoNoVacio([producto['brands']]);

    return ProductoOFF(
      barcode: barcode,
      nombre: marca == null ? nombre : '$nombre - $marca',
      caloriasPor100g: calorias,
      proteinasPor100g: _comoDouble(nutrientes['proteins_100g']) ?? 0,
      carbohidratosPor100g:
          _comoDouble(nutrientes['carbohydrates_100g']) ?? 0,
      grasasPor100g: _comoDouble(nutrientes['fat_100g']) ?? 0,
    );
  }

  /// La API a veces manda números como int, double o incluso String.
  static double? _comoDouble(Object? valor) {
    if (valor is num) return valor.toDouble();
    if (valor is String) return double.tryParse(valor);
    return null;
  }

  static String? _primerTextoNoVacio(List<Object?> valores) {
    for (final v in valores) {
      if (v is String && v.trim().isNotEmpty) return v.trim();
    }
    return null;
  }
}
