import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../app/appbar_volver.dart';
import '../../../core/database/database.dart';
import '../../perfil/domain/unidades.dart';
import '../../perfil/presentation/perfil_providers.dart';
import 'habitos_providers.dart';

/// Evolución del peso corporal: gráfico de línea + historial + alta rápida.
class PesoScreen extends ConsumerWidget {
  const PesoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pesosAsync = ref.watch(pesosProvider);
    final unidad = ref.watch(perfilActualProvider).value?.unidadPeso ?? 'kg';

    return Scaffold(
      appBar: appBarConVolver(context, 'Peso corporal'),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _dialogoRegistrar(context, ref, unidad),
        icon: const Icon(Icons.add),
        label: const Text('Peso'),
      ),
      body: pesosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (pesos) {
          if (pesos.isEmpty) {
            return const Center(
              child: Text('Registrá tu primer peso con el botón de abajo. ⚖️'),
            );
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            children: [
              if (pesos.length >= 2) ...[
                SizedBox(height: 220, child: _grafico(context, pesos, unidad)),
                const SizedBox(height: 16),
              ] else
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                      'Con dos o más registros vas a ver acá tu gráfico de '
                      'evolución. 📈'),
                ),
              Text('Historial', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              // Mostramos el historial del más nuevo al más viejo.
              for (final p in pesos.reversed)
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  child: ListTile(
                    title: Text(formatearPeso(p.pesoKg, unidad)),
                    subtitle:
                        Text(DateFormat('d/M/y – HH:mm').format(p.fecha)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => ref
                          .read(habitosRepositoryProvider)
                          .eliminarPeso(p.id),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _grafico(BuildContext context, List<WeightEntry> pesos, String unidad) {
    final tema = Theme.of(context);
    // Últimos 30 registros como máximo para que el gráfico no se sature.
    final visibles =
        pesos.length > 30 ? pesos.sublist(pesos.length - 30) : pesos;

    final puntos = [
      for (var i = 0; i < visibles.length; i++)
        FlSpot(i.toDouble(), desdeKg(visibles[i].pesoKg, unidad)),
    ];

    // Margen vertical para que la línea no toque los bordes.
    final valores = visibles.map((p) => desdeKg(p.pesoKg, unidad));
    final minY = valores.reduce((a, b) => a < b ? a : b) - 1;
    final maxY = valores.reduce((a, b) => a > b ? a : b) + 1;

    return LineChart(
      LineChartData(
        minY: minY,
        maxY: maxY,
        gridData: const FlGridData(drawVerticalLine: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              // Mostramos fecha solo en el primero, el del medio y el último
              // para que no se encimen las etiquetas.
              getTitlesWidget: (valor, meta) {
                final i = valor.toInt();
                final esBorde = i == 0 ||
                    i == visibles.length - 1 ||
                    i == visibles.length ~/ 2;
                if (!esBorde || i >= visibles.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    DateFormat('d/M').format(visibles[i].fecha),
                    style: tema.textTheme.bodySmall,
                  ),
                );
              },
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: puntos,
            isCurved: true,
            color: tema.colorScheme.primary,
            barWidth: 3,
            dotData: FlDotData(show: visibles.length <= 15),
            belowBarData: BarAreaData(
              show: true,
              color: tema.colorScheme.primary.withValues(alpha: 0.15),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _dialogoRegistrar(
      BuildContext context, WidgetRef ref, String unidad) async {
    final ctrl = TextEditingController();
    final guardado = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Registrar peso'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: 'Peso actual',
            suffixText: unidad,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancelar')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Guardar')),
        ],
      ),
    );

    if (guardado == true) {
      final ingresado = double.tryParse(ctrl.text.replaceAll(',', '.'));
      // Convertimos a kg ANTES de validar y guardar: la base siempre en kg.
      final peso = ingresado == null ? null : aKg(ingresado, unidad);
      if (peso != null && peso >= 25 && peso <= 400) {
        await ref.read(habitosRepositoryProvider).registrarPeso(peso);
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Peso inválido, no se guardó.')));
      }
    }
    ctrl.dispose();
  }
}
