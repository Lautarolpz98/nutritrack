import 'package:flutter_test/flutter_test.dart';
import 'package:nutritrack/features/comidas/domain/analisis_foto.dart';

void main() {
  const jsonValido = '''
{"items": [{"nombre": "Milanesa", "porcion_estimada_g": 180, "calorias": 420,
"proteinas_g": 35, "carbohidratos_g": 18, "grasas_g": 22},
{"nombre": "Puré de papa", "porcion_estimada_g": 200, "calorias": 210,
"proteinas_g": 4, "carbohidratos_g": 35, "grasas_g": 6}],
"confianza": "media", "notas": "Asumí milanesa de carne frita."}''';

  group('AnalisisFoto.desdeTexto', () {
    test('parsea JSON limpio', () {
      final a = AnalisisFoto.desdeTexto(jsonValido);
      expect(a, isNotNull);
      expect(a!.items.length, 2);
      expect(a.items[0].nombre, 'Milanesa');
      expect(a.items[0].porcionEstimadaG, 180);
      expect(a.items[0].calorias, 420);
      expect(a.items[1].carbohidratosG, 35);
      expect(a.confianza, 'media');
      expect(a.notas, contains('milanesa'));
    });

    test('parsea JSON envuelto en fences de markdown', () {
      final a = AnalisisFoto.desdeTexto('```json\n$jsonValido\n```');
      expect(a, isNotNull);
      expect(a!.items.length, 2);
    });

    test('parsea JSON con texto alrededor', () {
      final a = AnalisisFoto.desdeTexto(
          'Acá está el análisis que pediste:\n$jsonValido\n¡Espero que sirva!');
      expect(a, isNotNull);
      expect(a!.items.length, 2);
    });

    test('texto sin JSON devuelve null', () {
      expect(AnalisisFoto.desdeTexto('No pude analizar la imagen.'), isNull);
    });

    test('items inválidos se descartan sin romper los válidos', () {
      const json = '''
{"items": [
  {"nombre": "Ensalada", "calorias": 80},
  {"nombre": "", "calorias": 100},
  {"porcion_estimada_g": 50},
  "esto no es un objeto"
], "confianza": "alta", "notas": ""}''';

      final a = AnalisisFoto.desdeTexto(json);
      expect(a!.items.length, 1);
      expect(a.items[0].nombre, 'Ensalada');
      // Los campos que faltaban quedan en 0.
      expect(a.items[0].proteinasG, 0);
    });

    test('confianza desconocida cae a "baja"', () {
      const json =
          '{"items": [], "confianza": "altísima", "notas": "sin comida"}';
      final a = AnalisisFoto.desdeTexto(json);
      expect(a!.confianza, 'baja');
      expect(a.items, isEmpty);
    });

    test('números como String se convierten', () {
      const json = '''
{"items": [{"nombre": "Sopa", "porcion_estimada_g": "300",
"calorias": "150.5", "proteinas_g": "5", "carbohidratos_g": "20",
"grasas_g": "4"}], "confianza": "alta", "notas": ""}''';
      final a = AnalisisFoto.desdeTexto(json);
      expect(a!.items[0].calorias, 150.5);
      expect(a.items[0].porcionEstimadaG, 300);
    });
  });
}
