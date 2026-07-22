import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database.dart';
import '../../../core/database/database_provider.dart';
import '../data/habitos_repository.dart';

final habitosRepositoryProvider = Provider<HabitosRepository>((ref) {
  return HabitosRepository(ref.watch(databaseProvider));
});

/// Mililitros de agua tomados hoy.
final aguaDeHoyProvider = StreamProvider.autoDispose<int>((ref) {
  return ref.watch(habitosRepositoryProvider).observarAguaDelDia(DateTime.now());
});

/// Registro de sueño de hoy (null si todavía no se cargó).
final suenoDeHoyProvider = StreamProvider.autoDispose<SleepEntry?>((ref) {
  return ref
      .watch(habitosRepositoryProvider)
      .observarSuenoDelDia(DateTime.now());
});

/// Historial completo de peso (para el gráfico) y último valor.
final pesosProvider = StreamProvider.autoDispose<List<WeightEntry>>((ref) {
  return ref.watch(habitosRepositoryProvider).observarPesos();
});
