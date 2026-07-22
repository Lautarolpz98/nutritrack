import '../../../core/database/database.dart';

/// Suma de calorías y macros de un conjunto de comidas.
/// Función pura: recibe la lista y devuelve los totales, sin tocar la DB.
class TotalesDia {
  const TotalesDia({
    this.calorias = 0,
    this.proteinasG = 0,
    this.carbohidratosG = 0,
    this.grasasG = 0,
  });

  final double calorias;
  final double proteinasG;
  final double carbohidratosG;
  final double grasasG;
}

TotalesDia calcularTotales(Iterable<FoodEntry> comidas) {
  var calorias = 0.0;
  var proteinas = 0.0;
  var carbohidratos = 0.0;
  var grasas = 0.0;

  for (final c in comidas) {
    calorias += c.calorias;
    proteinas += c.proteinasG;
    carbohidratos += c.carbohidratosG;
    grasas += c.grasasG;
  }

  return TotalesDia(
    calorias: calorias,
    proteinasG: proteinas,
    carbohidratosG: carbohidratos,
    grasasG: grasas,
  );
}
