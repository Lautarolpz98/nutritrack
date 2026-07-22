import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database.dart';
import '../../../core/database/database_provider.dart';
import '../../comidas/presentation/comidas_providers.dart';
import '../../ejercicio/presentation/ejercicio_providers.dart';
import '../../sueno/presentation/habitos_providers.dart';
import '../data/historial_repository.dart';

/// Providers "family": reciben la fecha elegida en el calendario como
/// parámetro y devuelven los datos de ESE día.
final comidasDeFechaProvider = StreamProvider.autoDispose
    .family<List<FoodEntry>, DateTime>((ref, fecha) {
  return ref.watch(comidasRepositoryProvider).observarComidasDelDia(fecha);
});

final ejerciciosDeFechaProvider = StreamProvider.autoDispose
    .family<List<ExerciseEntry>, DateTime>((ref, fecha) {
  return ref.watch(ejercicioRepositoryProvider).observarDelDia(fecha);
});

final aguaDeFechaProvider =
    StreamProvider.autoDispose.family<int, DateTime>((ref, fecha) {
  return ref.watch(habitosRepositoryProvider).observarAguaDelDia(fecha);
});

final suenoDeFechaProvider =
    StreamProvider.autoDispose.family<SleepEntry?, DateTime>((ref, fecha) {
  return ref.watch(habitosRepositoryProvider).observarSuenoDelDia(fecha);
});

final historialRepositoryProvider = Provider<HistorialRepository>((ref) {
  return HistorialRepository(ref.watch(databaseProvider));
});

/// Un día con su valor agregado (para los gráficos de barras).
class DiaValor {
  const DiaValor(this.dia, this.valor);
  final DateTime dia;
  final double valor;
}

/// Datos agregados de los últimos N días para la pestaña de gráficos.
class ResumenRango {
  const ResumenRango({
    required this.caloriasPorDia,
    required this.suenoPorDia,
    required this.pesos,
  });

  final List<DiaValor> caloriasPorDia;
  final List<DiaValor> suenoPorDia;
  final List<WeightEntry> pesos;
}

/// family: el parámetro es la cantidad de días (7 o 30).
final resumenRangoProvider =
    FutureProvider.autoDispose.family<ResumenRango, int>((ref, dias) async {
  final repo = ref.watch(historialRepositoryProvider);
  final hoy = DateTime.now();
  final inicioHoy = DateTime(hoy.year, hoy.month, hoy.day);
  final desde = inicioHoy.subtract(Duration(days: dias - 1));
  final hasta = inicioHoy.add(const Duration(days: 1));

  final comidas = await repo.comidasEntre(desde, hasta);
  final sueno = await repo.suenoEntre(desde, hasta);
  final pesos = await repo.pesosEntre(desde, hasta);

  // Agrupamos por día calendario, rellenando con 0 los días sin datos
  // (así el gráfico siempre tiene N barras).
  final caloriasPorDia = <DiaValor>[];
  final suenoPorDia = <DiaValor>[];
  for (var i = 0; i < dias; i++) {
    final dia = desde.add(Duration(days: i));
    final finDia = dia.add(const Duration(days: 1));

    final kcal = comidas
        .where((c) => !c.fecha.isBefore(dia) && c.fecha.isBefore(finDia))
        .fold<double>(0, (suma, c) => suma + c.calorias);
    caloriasPorDia.add(DiaValor(dia, kcal));

    final horas = sueno
        .where((s) => !s.fecha.isBefore(dia) && s.fecha.isBefore(finDia))
        .fold<double>(0, (suma, s) => suma + s.horas);
    suenoPorDia.add(DiaValor(dia, horas));
  }

  return ResumenRango(
    caloriasPorDia: caloriasPorDia,
    suenoPorDia: suenoPorDia,
    pesos: pesos,
  );
});
