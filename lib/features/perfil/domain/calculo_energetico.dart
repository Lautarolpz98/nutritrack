import '../../../core/modelos/enums.dart';

/// Lógica pura de cálculo energético. "Pura" significa que no depende de
/// Flutter ni de la base de datos: recibe números y devuelve números.
/// Eso la hace trivial de testear (ver test/calculo_energetico_test.dart).

/// Tasa Metabólica Basal según Mifflin-St Jeor (kcal/día).
///
/// Hombres:  10·peso + 6.25·altura − 5·edad + 5
/// Mujeres:  10·peso + 6.25·altura − 5·edad − 161
double calcularTmb({
  required Sexo sexo,
  required double pesoKg,
  required double alturaCm,
  required int edad,
}) {
  final base = 10 * pesoKg + 6.25 * alturaCm - 5 * edad;
  return sexo == Sexo.masculino ? base + 5 : base - 161;
}

/// Gasto energético diario total: TMB × factor de actividad.
double calcularTdee(double tmb, NivelActividad nivel) => tmb * nivel.factor;

/// Objetivo calórico diario: TDEE ± ajuste según el objetivo.
/// Nunca devuelve menos de 1200 kcal (piso de seguridad).
int calcularObjetivoCalorico(double tdee, Objetivo objetivo) {
  final resultado = (tdee + objetivo.ajusteKcal).round();
  return resultado < 1200 ? 1200 : resultado;
}

/// Reparto de macros a partir de las calorías objetivo.
///
/// Usamos un reparto estándar 30% proteína / 40% carbohidratos / 30% grasas.
/// Conversión: proteína y carbohidratos aportan 4 kcal/g, grasas 9 kcal/g.
class MacrosObjetivo {
  const MacrosObjetivo({
    required this.proteinasG,
    required this.carbohidratosG,
    required this.grasasG,
  });

  final double proteinasG;
  final double carbohidratosG;
  final double grasasG;
}

MacrosObjetivo calcularMacros(int calorias) {
  return MacrosObjetivo(
    proteinasG: (calorias * 0.30) / 4,
    carbohidratosG: (calorias * 0.40) / 4,
    grasasG: (calorias * 0.30) / 9,
  );
}

/// Objetivo de agua diario: regla simple de 35 ml por kg de peso corporal.
int calcularObjetivoAguaMl(double pesoKg) => (pesoKg * 35).round();
