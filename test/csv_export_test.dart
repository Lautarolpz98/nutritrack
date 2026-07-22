import 'package:flutter_test/flutter_test.dart';
import 'package:nutritrack/core/database/database.dart';
import 'package:nutritrack/core/modelos/enums.dart';
import 'package:nutritrack/features/historial/domain/csv_export.dart';

void main() {
  group('generarCsv', () {
    test('arma encabezados y filas separados por coma', () {
      final csv = generarCsv(['a', 'b'], [
        [1, 2],
        [3, 4],
      ]);
      expect(csv.trim().split('\n'), ['a,b', '1,2', '3,4']);
    });

    test('escapa valores con comas y comillas', () {
      final csv = generarCsv(['nombre'], [
        ['Milanesa, con puré'],
        ['El "especial"'],
      ]);
      final lineas = csv.trim().split('\n');
      expect(lineas[1], '"Milanesa, con puré"');
      expect(lineas[2], '"El ""especial"""');
    });

    test('null queda como celda vacía', () {
      final csv = generarCsv(['a', 'b'], [
        [null, 'x'],
      ]);
      expect(csv.trim().split('\n')[1], ',x');
    });

    test('fechas en formato ISO legible', () {
      final csv = generarCsv(['fecha'], [
        [DateTime(2026, 7, 21, 9, 5)],
      ]);
      expect(csv.trim().split('\n')[1], '2026-07-21 09:05');
    });
  });

  test('csvComidas exporta todos los campos', () {
    final comidas = [
      FoodEntry(
        id: 1,
        nombre: 'Yogur, bebible',
        calorias: 120,
        proteinasG: 6,
        carbohidratosG: 18,
        grasasG: 2.5,
        porcionGramos: 200,
        momento: MomentoComida.desayuno,
        origen: OrigenRegistro.barcode,
        barcode: '779123',
        fecha: DateTime(2026, 7, 21, 8, 30),
      ),
    ];

    final lineas = csvComidas(comidas).trim().split('\n');
    expect(lineas.length, 2);
    expect(lineas[0], contains('fecha,momento,nombre'));
    // El nombre con coma tiene que ir entre comillas.
    expect(lineas[1], contains('"Yogur, bebible"'));
    expect(lineas[1], contains('desayuno'));
    expect(lineas[1], contains('779123'));
  });
}
