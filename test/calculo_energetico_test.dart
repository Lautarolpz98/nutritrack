import 'package:flutter_test/flutter_test.dart';
import 'package:nutritrack/core/modelos/enums.dart';
import 'package:nutritrack/features/perfil/domain/calculo_energetico.dart';

void main() {
  group('calcularTmb (Mifflin-St Jeor)', () {
    test('hombre de 80 kg, 180 cm, 30 años', () {
      // 10*80 + 6.25*180 - 5*30 + 5 = 800 + 1125 - 150 + 5 = 1780
      final tmb = calcularTmb(
        sexo: Sexo.masculino,
        pesoKg: 80,
        alturaCm: 180,
        edad: 30,
      );
      expect(tmb, 1780);
    });

    test('mujer de 60 kg, 165 cm, 25 años', () {
      // 10*60 + 6.25*165 - 5*25 - 161 = 600 + 1031.25 - 125 - 161 = 1345.25
      final tmb = calcularTmb(
        sexo: Sexo.femenino,
        pesoKg: 60,
        alturaCm: 165,
        edad: 25,
      );
      expect(tmb, closeTo(1345.25, 0.01));
    });

    test('la TMB del hombre supera a la de la mujer con mismos datos', () {
      final hombre = calcularTmb(
          sexo: Sexo.masculino, pesoKg: 70, alturaCm: 170, edad: 40);
      final mujer = calcularTmb(
          sexo: Sexo.femenino, pesoKg: 70, alturaCm: 170, edad: 40);
      expect(hombre - mujer, 166); // diferencia fija de la fórmula: 5-(-161)
    });
  });

  group('calcularTdee', () {
    test('aplica el factor de actividad', () {
      expect(calcularTdee(1780, NivelActividad.sedentario), closeTo(2136, 0.01));
      expect(calcularTdee(1780, NivelActividad.moderado), closeTo(2759, 0.01));
      expect(calcularTdee(1780, NivelActividad.muyActivo), closeTo(3382, 0.01));
    });
  });

  group('calcularObjetivoCalorico', () {
    test('bajar de peso resta 500 kcal', () {
      expect(calcularObjetivoCalorico(2500, Objetivo.bajar), 2000);
    });

    test('mantener no ajusta', () {
      expect(calcularObjetivoCalorico(2500, Objetivo.mantener), 2500);
    });

    test('subir de peso suma 300 kcal', () {
      expect(calcularObjetivoCalorico(2500, Objetivo.subir), 2800);
    });

    test('nunca baja del piso de 1200 kcal', () {
      expect(calcularObjetivoCalorico(1400, Objetivo.bajar), 1200);
    });
  });

  group('calcularMacros', () {
    test('reparto 30/40/30 con 2000 kcal', () {
      final m = calcularMacros(2000);
      // 30% de 2000 = 600 kcal / 4 = 150 g de proteína
      expect(m.proteinasG, 150);
      // 40% de 2000 = 800 kcal / 4 = 200 g de carbohidratos
      expect(m.carbohidratosG, 200);
      // 30% de 2000 = 600 kcal / 9 = 66.67 g de grasas
      expect(m.grasasG, closeTo(66.67, 0.01));
    });

    test('las calorías de los macros suman el total', () {
      final m = calcularMacros(2500);
      final kcal = m.proteinasG * 4 + m.carbohidratosG * 4 + m.grasasG * 9;
      expect(kcal, closeTo(2500, 0.01));
    });
  });

  group('calcularObjetivoAguaMl', () {
    test('35 ml por kg', () {
      expect(calcularObjetivoAguaMl(80), 2800);
      expect(calcularObjetivoAguaMl(60), 2100);
    });
  });
}
