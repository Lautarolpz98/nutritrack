import 'package:flutter_test/flutter_test.dart';
import 'package:nutritrack/features/pasos/domain/calculo_pasos.dart';

void main() {
  group('procesarLecturaSensor', () {
    test('primera lectura del día: arranca en 0 con la lectura como base', () {
      final e = procesarLecturaSensor(lectura: 52340);
      expect(e.pasosHoy, 0);
      expect(e.ultimoValorSensor, 52340);
    });

    test('lectura normal: suma la diferencia', () {
      final e = procesarLecturaSensor(
        lectura: 52540,
        pasosGuardadosHoy: 1000,
        ultimoValorGuardado: 52340,
      );
      expect(e.pasosHoy, 1200); // 1000 + (52540 - 52340)
      expect(e.ultimoValorSensor, 52540);
    });

    test('lectura igual no suma nada', () {
      final e = procesarLecturaSensor(
        lectura: 52340,
        pasosGuardadosHoy: 500,
        ultimoValorGuardado: 52340,
      );
      expect(e.pasosHoy, 500);
    });

    test('reinicio del teléfono: el contador vuelve a 0 y se suma completo',
        () {
      // Ayer el sensor iba por 52340; el teléfono se reinició y ahora
      // marca 80 (todos pasos nuevos).
      final e = procesarLecturaSensor(
        lectura: 80,
        pasosGuardadosHoy: 3000,
        ultimoValorGuardado: 52340,
      );
      expect(e.pasosHoy, 3080);
      expect(e.ultimoValorSensor, 80);
    });
  });

  group('caloriasPorPasos', () {
    test('10.000 pasos con 70 kg ≈ 350 kcal', () {
      expect(caloriasPorPasos(10000, 70), closeTo(350, 0.01));
    });

    test('0 pasos = 0 kcal', () {
      expect(caloriasPorPasos(0, 80), 0);
    });

    test('a mayor peso, más calorías por los mismos pasos', () {
      expect(caloriasPorPasos(5000, 90),
          greaterThan(caloriasPorPasos(5000, 60)));
    });
  });
}
