import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'habitos_providers.dart';

/// Hoja inferior para registrar el sueño de anoche: o ponés las horas
/// directamente, o elegís a qué hora te acostaste y te levantaste.
class RegistrarSuenoSheet extends ConsumerStatefulWidget {
  const RegistrarSuenoSheet({super.key});

  static Future<void> mostrar(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true, // para que el teclado no tape los campos
      builder: (_) => const RegistrarSuenoSheet(),
    );
  }

  @override
  ConsumerState<RegistrarSuenoSheet> createState() =>
      _RegistrarSuenoSheetState();
}

class _RegistrarSuenoSheetState extends ConsumerState<RegistrarSuenoSheet> {
  bool _modoHorarios = false;
  final _horasCtrl = TextEditingController(text: '8');
  TimeOfDay _acostarse = const TimeOfDay(hour: 23, minute: 30);
  TimeOfDay _levantarse = const TimeOfDay(hour: 7, minute: 30);

  @override
  void dispose() {
    _horasCtrl.dispose();
    super.dispose();
  }

  /// Duración entre acostarse y levantarse, contemplando el cruce de
  /// medianoche (23:30 → 07:30 = 8 h).
  double get _horasDesdeHorarios {
    var minutos = (_levantarse.hour * 60 + _levantarse.minute) -
        (_acostarse.hour * 60 + _acostarse.minute);
    if (minutos <= 0) minutos += 24 * 60;
    return minutos / 60;
  }

  Future<void> _guardar() async {
    final double horas;
    DateTime? acostarse;
    DateTime? levantarse;

    if (_modoHorarios) {
      horas = _horasDesdeHorarios;
      final hoy = DateTime.now();
      // Reconstruimos las fechas: si te acostaste "más tarde" que la hora
      // de levantarte, fue ayer a la noche.
      levantarse = DateTime(
          hoy.year, hoy.month, hoy.day, _levantarse.hour, _levantarse.minute);
      acostarse = DateTime(
          hoy.year, hoy.month, hoy.day, _acostarse.hour, _acostarse.minute);
      if (!acostarse.isBefore(levantarse)) {
        acostarse = acostarse.subtract(const Duration(days: 1));
      }
    } else {
      final valor = double.tryParse(_horasCtrl.text.replaceAll(',', '.'));
      if (valor == null || valor <= 0 || valor > 24) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Ingresá una cantidad de horas válida (0-24)')));
        return;
      }
      horas = valor;
    }

    await ref.read(habitosRepositoryProvider).registrarSueno(
        horas: horas, acostarse: acostarse, levantarse: levantarse);
    if (mounted) Navigator.pop(context);
  }

  Future<void> _elegirHora({required bool esAcostarse}) async {
    final elegida = await showTimePicker(
      context: context,
      initialTime: esAcostarse ? _acostarse : _levantarse,
    );
    if (elegida == null) return;
    setState(() {
      if (esAcostarse) {
        _acostarse = elegida;
      } else {
        _levantarse = elegida;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // El viewInsets corre el contenido hacia arriba cuando sale el teclado.
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('¿Cuánto dormiste anoche?',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: false, label: Text('Duración')),
              ButtonSegment(value: true, label: Text('Horarios')),
            ],
            selected: {_modoHorarios},
            onSelectionChanged: (v) =>
                setState(() => _modoHorarios = v.first),
          ),
          const SizedBox(height: 16),
          if (!_modoHorarios)
            TextField(
              controller: _horasCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Horas de sueño',
                suffixText: 'h',
                border: OutlineInputBorder(),
              ),
            )
          else ...[
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _elegirHora(esAcostarse: true),
                    icon: const Icon(Icons.bedtime_outlined),
                    label: Text('Me acosté ${_acostarse.format(context)}'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _elegirHora(esAcostarse: false),
                    icon: const Icon(Icons.wb_sunny_outlined),
                    label: Text('Me levanté ${_levantarse.format(context)}'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Total: ${_horasDesdeHorarios.toStringAsFixed(1)} horas',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
          const SizedBox(height: 16),
          FilledButton(onPressed: _guardar, child: const Text('Guardar')),
        ],
      ),
    );
  }
}
