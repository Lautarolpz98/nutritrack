import 'package:flutter_test/flutter_test.dart';
import 'package:nutritrack/core/database/database.dart';
import 'package:nutritrack/core/modelos/enums.dart';
import 'package:nutritrack/features/comidas/domain/totales_dia.dart';

/// Helper para armar un FoodEntry de prueba sin repetir todos los campos.
FoodEntry comida({
  double calorias = 0,
  double proteinas = 0,
  double carbos = 0,
  double grasas = 0,
}) {
  return FoodEntry(
    id: 1,
    nombre: 'test',
    calorias: calorias,
    proteinasG: proteinas,
    carbohidratosG: carbos,
    grasasG: grasas,
    porcionGramos: null,
    momento: MomentoComida.almuerzo,
    origen: OrigenRegistro.manual,
    barcode: null,
    fecha: DateTime(2026, 7, 21, 13, 0),
  );
}

void main() {
  group('calcularTotales', () {
    test('lista vacía devuelve todo en cero', () {
      final t = calcularTotales(const []);
      expect(t.calorias, 0);
      expect(t.proteinasG, 0);
      expect(t.carbohidratosG, 0);
      expect(t.grasasG, 0);
    });

    test('suma calorías y macros de varias comidas', () {
      final t = calcularTotales([
        comida(calorias: 450, proteinas: 30, carbos: 40, grasas: 15),
        comida(calorias: 320.5, proteinas: 12.5, carbos: 55, grasas: 8),
        comida(calorias: 100, proteinas: 0, carbos: 25, grasas: 0),
      ]);
      expect(t.calorias, closeTo(870.5, 0.001));
      expect(t.proteinasG, closeTo(42.5, 0.001));
      expect(t.carbohidratosG, closeTo(120, 0.001));
      expect(t.grasasG, closeTo(23, 0.001));
    });
  });
}
