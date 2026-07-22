import 'package:flutter_test/flutter_test.dart';
import 'package:nutritrack/features/ejercicio/domain/rutina_sugerida.dart';

void main() {
  const jsonValido = '''
{"ejercicios": [
  {"nombre": "Caminata rápida", "series": null, "repeticiones": null,
   "duracion_min": 20, "descripcion": "Ritmo que te agite un poco."},
  {"nombre": "Sentadillas", "series": 3, "repeticiones": 12,
   "duracion_min": null, "descripcion": "Espalda recta."},
  {"nombre": "Plancha", "series": 3, "repeticiones": null,
   "duracion_min": 1, "descripcion": "Abdomen firme."}
], "notas": "Hidratate bien durante el día."}''';

  group('RutinaSugerida.desdeTexto', () {
    test('parsea una rutina completa', () {
      final r = RutinaSugerida.desdeTexto(jsonValido);
      expect(r, isNotNull);
      expect(r!.ejercicios.length, 3);

      final caminata = r.ejercicios[0];
      expect(caminata.nombre, 'Caminata rápida');
      expect(caminata.series, isNull);
      expect(caminata.duracionMin, 20);

      final sentadillas = r.ejercicios[1];
      expect(sentadillas.series, 3);
      expect(sentadillas.repeticiones, 12);
      expect(sentadillas.duracionMin, isNull);

      expect(r.notas, contains('Hidratate'));
    });

    test('parsea con fences de markdown', () {
      final r = RutinaSugerida.desdeTexto('```json\n$jsonValido\n```');
      expect(r, isNotNull);
      expect(r!.ejercicios.length, 3);
    });

    test('rutina sin ejercicios devuelve null', () {
      expect(RutinaSugerida.desdeTexto('{"ejercicios": [], "notas": "x"}'),
          isNull);
    });

    test('texto sin JSON devuelve null', () {
      expect(RutinaSugerida.desdeTexto('hoy descansá'), isNull);
    });

    test('ejercicios sin nombre se descartan', () {
      const json = '''
{"ejercicios": [
  {"series": 3, "repeticiones": 10},
  {"nombre": "Burpees", "series": 3, "repeticiones": 8, "descripcion": ""}
], "notas": ""}''';
      final r = RutinaSugerida.desdeTexto(json);
      expect(r!.ejercicios.length, 1);
      expect(r.ejercicios[0].nombre, 'Burpees');
    });

    test('números como String se convierten', () {
      const json = '''
{"ejercicios": [{"nombre": "Bici", "duracion_min": "45",
"series": null, "repeticiones": null, "descripcion": ""}], "notas": ""}''';
      final r = RutinaSugerida.desdeTexto(json);
      expect(r!.ejercicios[0].duracionMin, 45);
    });
  });
}
