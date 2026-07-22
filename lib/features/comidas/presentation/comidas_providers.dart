import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database.dart';
import '../../../core/database/database_provider.dart';
import '../data/comidas_repository.dart';
import '../domain/totales_dia.dart';

final comidasRepositoryProvider = Provider<ComidasRepository>((ref) {
  return ComidasRepository(ref.watch(databaseProvider));
});

/// Comidas del día de hoy, como stream reactivo.
///
/// autoDispose: cuando nadie mira el dashboard, el stream se cierra; al
/// volver se recrea (y con eso también se refresca el "hoy" si cambió el día).
final comidasDeHoyProvider =
    StreamProvider.autoDispose<List<FoodEntry>>((ref) {
  return ref
      .watch(comidasRepositoryProvider)
      .observarComidasDelDia(DateTime.now());
});

/// Totales del día derivados de la lista anterior. Si todavía está
/// cargando, devuelve totales en cero (la UI muestra 0 sin parpadeos).
final totalesDeHoyProvider = Provider.autoDispose<TotalesDia>((ref) {
  // .value devuelve null mientras el stream todavía no emitió nada.
  final comidas = ref.watch(comidasDeHoyProvider).value ?? const <FoodEntry>[];
  return calcularTotales(comidas);
});
