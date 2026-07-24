/// Formato de agua en litros (guardamos ml en la base, mostramos L).
///
/// Ejemplos: 250 → "0.25", 1500 → "1.5", 2800 → "2.8", 3000 → "3".
String formatearLitros(int ml) {
  final texto = (ml / 1000).toStringAsFixed(2);
  // Sacamos ceros de más al final ("2.80" → "2.8", "3.00" → "3").
  return texto.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
}
