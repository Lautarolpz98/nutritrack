import 'package:flutter_test/flutter_test.dart';
import 'package:nutritrack/features/sueno/domain/agua_formato.dart';

void main() {
  group('formatearLitros', () {
    test('convierte ml a litros sin ceros de más', () {
      expect(formatearLitros(250), '0.25');
      expect(formatearLitros(1500), '1.5');
      expect(formatearLitros(2800), '2.8');
      expect(formatearLitros(3000), '3');
      expect(formatearLitros(0), '0');
    });
  });
}
