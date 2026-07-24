import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/appbar_volver.dart';
import '../../../core/database/database.dart';
import 'ejercicio_providers.dart';

/// Ejercicio del día: lista, totales y acceso a agregar manual o pedir
/// una rutina a la IA.
class EjercicioScreen extends ConsumerWidget {
  const EjercicioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ejerciciosAsync = ref.watch(ejerciciosDeHoyProvider);

    return Scaffold(
      appBar: appBarConVolver(context, 'Ejercicio de hoy'),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/ejercicio/agregar'),
        icon: const Icon(Icons.add),
        label: const Text('Ejercicio'),
      ),
      body: ejerciciosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (ejercicios) {
          final totalKcal = ejercicios.fold<double>(
              0, (suma, e) => suma + e.caloriasQuemadas);
          final totalMin =
              ejercicios.fold<int>(0, (suma, e) => suma + e.duracionMin);

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _dato(context, '🔥 ${totalKcal.round()}', 'kcal quemadas'),
                      _dato(context, '⏱️ $totalMin', 'minutos'),
                      _dato(context, '💪 ${ejercicios.length}', 'actividades'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FilledButton.tonalIcon(
                onPressed: () => context.push('/ejercicio/rutina'),
                icon: const Icon(Icons.auto_awesome),
                label: const Text('Proponeme ejercicios (IA)'),
              ),
              const SizedBox(height: 12),
              if (ejercicios.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(
                        child: Text('Todavía no registraste ejercicio hoy. 🏃')),
                  ),
                )
              else
                for (final e in ejercicios)
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    child: ListTile(
                      title: Text(e.tipo),
                      subtitle: Text('${e.duracionMin} min'
                          '${e.notas == null || e.notas!.isEmpty ? '' : ' · ${e.notas}'}'),
                      trailing: Text('${e.caloriasQuemadas.round()} kcal',
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      onLongPress: () => _confirmarBorrado(context, ref, e),
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }

  Widget _dato(BuildContext context, String valor, String etiqueta) {
    return Column(
      children: [
        Text(valor, style: Theme.of(context).textTheme.titleLarge),
        Text(etiqueta, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Future<void> _confirmarBorrado(
      BuildContext context, WidgetRef ref, ExerciseEntry e) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Borrar ejercicio?'),
        content: Text('Se va a borrar "${e.tipo}".'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancelar')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Borrar')),
        ],
      ),
    );
    if (confirmado == true) {
      await ref.read(ejercicioRepositoryProvider).eliminar(e.id);
    }
  }
}
