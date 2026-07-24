import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/appbar_volver.dart';
import '../../../core/database/database.dart';
import '../../perfil/presentation/perfil_providers.dart';
import '../domain/calculo_ejercicio.dart';
import 'ejercicio_providers.dart';

/// Alta manual de ejercicio: elegís el tipo y la duración, y las calorías
/// se calculan solas con la tabla MET y tu peso (pero podés corregirlas).
class AgregarEjercicioScreen extends ConsumerStatefulWidget {
  const AgregarEjercicioScreen({super.key});

  @override
  ConsumerState<AgregarEjercicioScreen> createState() =>
      _AgregarEjercicioScreenState();
}

class _AgregarEjercicioScreenState
    extends ConsumerState<AgregarEjercicioScreen> {
  final _formKey = GlobalKey<FormState>();
  TipoEjercicio _tipo = TipoEjercicio.caminata;
  final _nombreCtrl = TextEditingController(); // solo para tipo "otro"
  final _duracionCtrl = TextEditingController(text: '30');
  final _kcalCtrl = TextEditingController();
  final _notasCtrl = TextEditingController();

  /// Si el usuario tocó las kcal a mano, dejamos de pisárselas.
  bool _kcalEditadaManual = false;
  bool _guardando = false;

  @override
  void initState() {
    super.initState();
    // Calculamos las kcal iniciales apenas tengamos el perfil.
    WidgetsBinding.instance.addPostFrameCallback((_) => _recalcularKcal());
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _duracionCtrl.dispose();
    _kcalCtrl.dispose();
    _notasCtrl.dispose();
    super.dispose();
  }

  void _recalcularKcal() {
    if (_kcalEditadaManual || _tipo == TipoEjercicio.otro) return;
    final peso = ref.read(perfilActualProvider).value?.pesoKg ?? 70;
    final minutos = int.tryParse(_duracionCtrl.text) ?? 0;
    final kcal =
        caloriasQuemadas(met: _tipo.met, pesoKg: peso, minutos: minutos);
    _kcalCtrl.text = kcal.round().toString();
    setState(() {});
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _guardando = true);

    final nombre = _tipo == TipoEjercicio.otro
        ? _nombreCtrl.text.trim()
        : _tipo.etiqueta;

    await ref.read(ejercicioRepositoryProvider).agregar(
          ExerciseEntriesCompanion.insert(
            tipo: nombre,
            duracionMin: int.parse(_duracionCtrl.text),
            caloriasQuemadas:
                double.tryParse(_kcalCtrl.text.replaceAll(',', '.')) ?? 0,
            notas: Value(
                _notasCtrl.text.trim().isEmpty ? null : _notasCtrl.text.trim()),
            fecha: DateTime.now(),
          ),
        );

    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarConVolver(context, 'Agregar ejercicio'),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<TipoEjercicio>(
              initialValue: _tipo,
              decoration: const InputDecoration(
                labelText: 'Actividad',
                border: OutlineInputBorder(),
              ),
              items: [
                for (final t in TipoEjercicio.values)
                  DropdownMenuItem(value: t, child: Text(t.etiqueta)),
              ],
              onChanged: (v) {
                _tipo = v!;
                _recalcularKcal();
              },
            ),
            if (_tipo == TipoEjercicio.otro) ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: _nombreCtrl,
                decoration: const InputDecoration(
                  labelText: '¿Qué actividad hiciste?',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (_tipo == TipoEjercicio.otro &&
                        (v == null || v.trim().isEmpty))
                    ? 'Poné un nombre'
                    : null,
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _duracionCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Duración',
                      suffixText: 'min',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      final n = int.tryParse(v ?? '');
                      if (n == null || n <= 0 || n > 600) {
                        return 'Duración inválida';
                      }
                      return null;
                    },
                    onChanged: (_) => _recalcularKcal(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _kcalCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Calorías',
                      suffixText: 'kcal',
                      border: OutlineInputBorder(),
                      helperText: 'Se calculan solas',
                    ),
                    validator: (v) {
                      final n = double.tryParse((v ?? '').replaceAll(',', '.'));
                      if (n == null || n < 0) return 'Inválido';
                      return null;
                    },
                    onChanged: (_) => _kcalEditadaManual = true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _notasCtrl,
              decoration: const InputDecoration(
                labelText: 'Notas (opcional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _guardando ? null : _guardar,
              child: _guardando
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
