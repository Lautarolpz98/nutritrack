import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/database.dart';
import '../../../core/modelos/enums.dart';
import 'comidas_providers.dart';

/// Alta y edición de una comida. Si [comidaExistente] viene con datos,
/// la pantalla funciona en modo edición.
class AgregarComidaScreen extends ConsumerStatefulWidget {
  const AgregarComidaScreen({super.key, this.comidaExistente});

  final FoodEntry? comidaExistente;

  @override
  ConsumerState<AgregarComidaScreen> createState() =>
      _AgregarComidaScreenState();
}

class _AgregarComidaScreenState extends ConsumerState<AgregarComidaScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nombreCtrl;
  late final TextEditingController _caloriasCtrl;
  late final TextEditingController _proteinasCtrl;
  late final TextEditingController _carbosCtrl;
  late final TextEditingController _grasasCtrl;
  late final TextEditingController _porcionCtrl;
  late MomentoComida _momento;
  bool _guardando = false;

  bool get _esEdicion => widget.comidaExistente != null;

  @override
  void initState() {
    super.initState();
    final c = widget.comidaExistente;
    _nombreCtrl = TextEditingController(text: c?.nombre ?? '');
    _caloriasCtrl =
        TextEditingController(text: c == null ? '' : _fmt(c.calorias));
    _proteinasCtrl =
        TextEditingController(text: c == null ? '' : _fmt(c.proteinasG));
    _carbosCtrl =
        TextEditingController(text: c == null ? '' : _fmt(c.carbohidratosG));
    _grasasCtrl =
        TextEditingController(text: c == null ? '' : _fmt(c.grasasG));
    _porcionCtrl = TextEditingController(
        text: c?.porcionGramos == null ? '' : _fmt(c!.porcionGramos!));
    _momento = c?.momento ?? _momentoSegunHora();
  }

  /// Números sin ".0" innecesario para mostrar en los campos.
  static String _fmt(double v) =>
      v == v.roundToDouble() ? v.round().toString() : v.toString();

  /// Pre-selecciona el momento del día según la hora actual: un detalle
  /// chico que ahorra un tap en el 90% de los casos.
  static MomentoComida _momentoSegunHora() {
    final hora = DateTime.now().hour;
    if (hora < 11) return MomentoComida.desayuno;
    if (hora < 15) return MomentoComida.almuerzo;
    if (hora < 19) return MomentoComida.snack;
    return MomentoComida.cena;
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _caloriasCtrl.dispose();
    _proteinasCtrl.dispose();
    _carbosCtrl.dispose();
    _grasasCtrl.dispose();
    _porcionCtrl.dispose();
    super.dispose();
  }

  double _num(TextEditingController ctrl) =>
      double.tryParse(ctrl.text.replaceAll(',', '.')) ?? 0;

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _guardando = true);

    final porcion = _num(_porcionCtrl);
    final companion = FoodEntriesCompanion(
      nombre: Value(_nombreCtrl.text.trim()),
      calorias: Value(_num(_caloriasCtrl)),
      proteinasG: Value(_num(_proteinasCtrl)),
      carbohidratosG: Value(_num(_carbosCtrl)),
      grasasG: Value(_num(_grasasCtrl)),
      porcionGramos: Value(porcion > 0 ? porcion : null),
      momento: Value(_momento),
      origen: Value(widget.comidaExistente?.origen ?? OrigenRegistro.manual),
      // En edición conservamos la fecha original del registro.
      fecha: Value(widget.comidaExistente?.fecha ?? DateTime.now()),
    );

    final repo = ref.read(comidasRepositoryProvider);
    if (_esEdicion) {
      await repo.actualizar(widget.comidaExistente!.id, companion);
    } else {
      await repo.agregar(companion);
    }

    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_esEdicion ? 'Editar comida' : 'Agregar comida'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nombreCtrl,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                hintText: 'Ej: Milanesa con puré',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Ingresá un nombre' : null,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _caloriasCtrl,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Calorías',
                      suffixText: 'kcal',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      final n =
                          double.tryParse((v ?? '').replaceAll(',', '.'));
                      if (n == null || n < 0) return 'Calorías inválidas';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _porcionCtrl,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Porción (opcional)',
                      suffixText: 'g',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('Macros (opcional)',
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _campoMacro(_proteinasCtrl, 'Proteínas')),
                const SizedBox(width: 8),
                Expanded(child: _campoMacro(_carbosCtrl, 'Carbos')),
                const SizedBox(width: 8),
                Expanded(child: _campoMacro(_grasasCtrl, 'Grasas')),
              ],
            ),
            const SizedBox(height: 16),
            Text('Momento del día',
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            SegmentedButton<MomentoComida>(
              segments: [
                for (final m in MomentoComida.values)
                  ButtonSegment(value: m, label: Text(m.etiqueta)),
              ],
              selected: {_momento},
              onSelectionChanged: (v) => setState(() => _momento = v.first),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _guardando ? null : _guardar,
              child: _guardando
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(_esEdicion ? 'Guardar cambios' : 'Agregar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _campoMacro(TextEditingController ctrl, String etiqueta) {
    return TextFormField(
      controller: ctrl,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: etiqueta,
        suffixText: 'g',
        border: const OutlineInputBorder(),
      ),
      validator: (v) {
        if (v == null || v.isEmpty) return null; // opcional
        final n = double.tryParse(v.replaceAll(',', '.'));
        if (n == null || n < 0) return 'Inválido';
        return null;
      },
    );
  }
}
