import 'package:flutter_test/flutter_test.dart';
import 'package:nutritrack/features/perfil/domain/unidades.dart';

void main() {
  group('conversión kg/lb', () {
    test('1 kg son ~2.2046 lb', () {
      expect(kgALb(1), closeTo(2.2046, 0.001));
    });

    test('ida y vuelta no pierde precisión', () {
      expect(lbAKg(kgALb(80)), closeTo(80, 0.0001));
    });

    test('aKg respeta la unidad', () {
      expect(aKg(80, 'kg'), 80);
      expect(aKg(176.37, 'lb'), closeTo(80, 0.01));
    });

    test('formatearPeso muestra la unidad elegida', () {
      expect(formatearPeso(80, 'kg'), '80.0 kg');
      expect(formatearPeso(80, 'lb'), '176.4 lb');
    });
  });
}
