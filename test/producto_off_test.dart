import 'package:flutter_test/flutter_test.dart';
import 'package:nutritrack/features/comidas/domain/producto_off.dart';

void main() {
  group('ProductoOFF.desdeRespuestaApi', () {
    test('parsea un producto completo', () {
      final json = {
        'status': 1,
        'product': {
          'product_name': 'Oreo Original',
          'brands': 'Mondelez',
          'nutriments': {
            'energy-kcal_100g': 480,
            'proteins_100g': 5.3,
            'carbohydrates_100g': 69,
            'fat_100g': 20.0,
          },
        },
      };

      final p = ProductoOFF.desdeRespuestaApi(json, '7622300489434');

      expect(p, isNotNull);
      expect(p!.barcode, '7622300489434');
      expect(p.nombre, 'Oreo Original - Mondelez');
      expect(p.caloriasPor100g, 480); // int convertido a double
      expect(p.proteinasPor100g, 5.3);
      expect(p.carbohidratosPor100g, 69);
      expect(p.grasasPor100g, 20.0);
    });

    test('prefiere el nombre en español si existe', () {
      final json = {
        'status': 1,
        'product': {
          'product_name_es': 'Galletitas de chocolate',
          'product_name': 'Chocolate cookies',
          'nutriments': {'energy-kcal_100g': 500},
        },
      };

      final p = ProductoOFF.desdeRespuestaApi(json, '123');
      expect(p!.nombre, 'Galletitas de chocolate');
    });

    test('status 0 (no encontrado) devuelve null', () {
      final p = ProductoOFF.desdeRespuestaApi(
          {'status': 0, 'status_verbose': 'product not found'}, '123');
      expect(p, isNull);
    });

    test('producto sin calorías devuelve null (no sirve para la app)', () {
      final json = {
        'status': 1,
        'product': {
          'product_name': 'Agua mineral rara',
          'nutriments': {'proteins_100g': 0},
        },
      };
      expect(ProductoOFF.desdeRespuestaApi(json, '123'), isNull);
    });

    test('macros faltantes quedan en 0 en vez de romper', () {
      final json = {
        'status': 1,
        'product': {
          'product_name': 'Caramelo',
          'nutriments': {'energy-kcal_100g': 390},
        },
      };

      final p = ProductoOFF.desdeRespuestaApi(json, '123');
      expect(p!.proteinasPor100g, 0);
      expect(p.carbohidratosPor100g, 0);
      expect(p.grasasPor100g, 0);
    });

    test('números que vienen como String se convierten igual', () {
      final json = {
        'status': 1,
        'product': {
          'product_name': 'Yogur',
          'nutriments': {
            'energy-kcal_100g': '89.5',
            'proteins_100g': '4.2',
          },
        },
      };

      final p = ProductoOFF.desdeRespuestaApi(json, '123');
      expect(p!.caloriasPor100g, 89.5);
      expect(p.proteinasPor100g, 4.2);
    });
  });
}
