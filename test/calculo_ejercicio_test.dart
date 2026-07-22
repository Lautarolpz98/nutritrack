import 'package:flutter_test/flutter_test.dart';
import 'package:nutritrack/features/ejercicio/domain/calculo_ejercicio.dart';

void main() {
  group('caloriasQuemadas (fórmula MET)', () {
    test('fútbol (8 MET), 70 kg, 30 min', () {
      // 8 × 3.5 × 70 / 200 × 30 = 294
      final kcal = caloriasQuemadas(met: 8, pesoKg: 70, minutos: 30);
      expect(kcal, closeTo(294, 0.01));
    });

    test('yoga (2.5 MET), 60 kg, 60 min', () {
      // 2.5 × 3.5 × 60 / 200 × 60 = 157.5
      final kcal = caloriasQuemadas(met: 2.5, pesoKg: 60, minutos: 60);
      expect(kcal, closeTo(157.5, 0.01));
    });

    test('a mayor peso, más calorías quemadas', () {
      final liviano = caloriasQuemadas(met: 5, pesoKg: 60, minutos: 30);
      final pesado = caloriasQuemadas(met: 5, pesoKg: 90, minutos: 30);
      expect(pesado, greaterThan(liviano));
    });

    test('duración cero quema cero', () {
      expect(caloriasQuemadas(met: 10, pesoKg: 80, minutos: 0), 0);
    });
  });

  test('todos los tipos de ejercicio tienen etiqueta', () {
    for (final tipo in TipoEjercicio.values) {
      expect(tipo.etiqueta, isNotEmpty);
    }
  });
}
