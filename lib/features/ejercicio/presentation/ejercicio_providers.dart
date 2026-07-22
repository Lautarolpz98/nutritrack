import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database.dart';
import '../../../core/database/database_provider.dart';
import '../data/ejercicio_repository.dart';

final ejercicioRepositoryProvider = Provider<EjercicioRepository>((ref) {
  return EjercicioRepository(ref.watch(databaseProvider));
});

final ejerciciosDeHoyProvider =
    StreamProvider.autoDispose<List<ExerciseEntry>>((ref) {
  return ref
      .watch(ejercicioRepositoryProvider)
      .observarDelDia(DateTime.now());
});
