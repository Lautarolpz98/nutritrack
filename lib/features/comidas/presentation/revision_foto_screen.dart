import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/appbar_volver.dart';
import '../../../core/database/database.dart';
import '../../../core/modelos/enums.dart';
import '../domain/analisis_foto.dart';
import 'comidas_providers.dart';

/// Paso 2 del flujo "foto con IA": revisar y corregir lo que detectó la IA
/// antes de guardarlo. Cada campo es editable y cada item se puede quitar.
class RevisionFotoScreen extends ConsumerStatefulWidget {
  const RevisionFotoScreen({super.key, required this.analisis});

  final AnalisisFoto analisis;

  @override
  ConsumerState<RevisionFotoScreen> createState() =>
      _RevisionFotoScreenState();
}

/// Controllers de un item editable (uno por campo).
class _ItemEditable {
  _ItemEditable(ItemDetectado item)
      : nombre = TextEditingController(text: item.nombre),
        porcion = TextEditingController(text: _fmt(item.porcionEstimadaG)),
        calorias = TextEditingController(text: _fmt(item.calorias)),
        proteinas = TextEditingController(text: _fmt(item.proteinasG)),
        carbos = TextEditingController(text: _fmt(item.carbohidratosG)),
        grasas = TextEditingController(text: _fmt(item.grasasG));

  final TextEditingController nombre;
  final TextEditingController porcion;
  final TextEditingController calorias;
  final TextEditingController proteinas;
  final TextEditingController carbos;
  final TextEditingController grasas;

  static String _fmt(double v) =>
      v == v.roundToDouble() ? v.round().toString() : v.toStringAsFixed(1);

  double num(TextEditingController c) =>
      double.tryParse(c.text.replaceAll(',', '.')) ?? 0;

  void dispose() {
    nombre.dispose();
    porcion.dispose();
    calorias.dispose();
    proteinas.dispose();
    carbos.dispose();
    grasas.dispose();
  }
}

class _RevisionFotoScreenState extends ConsumerState<RevisionFotoScreen> {
  late final List<_ItemEditable> _items;
  MomentoComida _momento = _momentoSegunHora();
  bool _guardando = false;

  static MomentoComida _momentoSegunHora() {
    final hora = DateTime.now().hour;
    if (hora < 11) return MomentoComida.desayuno;
    if (hora < 15) return MomentoComida.almuerzo;
    if (hora < 19) return MomentoComida.snack;
    return MomentoComida.cena;
  }

  @override
  void initState() {
    super.initState();
    _items = [for (final i in widget.analisis.items) _ItemEditable(i)];
  }

  @override
  void dispose() {
    for (final i in _items) {
      i.dispose();
    }
    super.dispose();
  }

  Future<void> _guardarTodo() async {
    setState(() => _guardando = true);
    final repo = ref.read(comidasRepositoryProvider);
    final ahora = DateTime.now();

    for (final item in _items) {
      if (item.nombre.text.trim().isEmpty) continue;
      final porcion = item.num(item.porcion);
      await repo.agregar(FoodEntriesCompanion.insert(
        nombre: item.nombre.text.trim(),
        calorias: item.num(item.calorias),
        proteinasG: Value(item.num(item.proteinas)),
        carbohidratosG: Value(item.num(item.carbos)),
        grasasG: Value(item.num(item.grasas)),
        porcionGramos: Value(porcion > 0 ? porcion : null),
        momento: _momento,
        origen: OrigenRegistro.foto,
        fecha: ahora,
      ));
    }

    if (mounted) context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final confianza = widget.analisis.confianza;
    return Scaffold(
      appBar: appBarConVolver(context, 'Revisar detección'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Aviso SIEMPRE visible: esto es una estimación.
          Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Icon(Icons.info_outline),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Estimación de IA (confianza $confianza). '
                      'Revisá y corregí los valores antes de guardar.',
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (widget.analisis.notas.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text('📝 ${widget.analisis.notas}',
                  style: Theme.of(context).textTheme.bodySmall),
            ),
          const SizedBox(height: 12),
          for (var i = 0; i < _items.length; i++) _tarjetaItem(i),
          const SizedBox(height: 8),
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
            onPressed: (_items.isEmpty || _guardando) ? null : _guardarTodo,
            child: _guardando
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2))
                : Text(_items.length == 1
                    ? 'Guardar 1 comida'
                    : 'Guardar ${_items.length} comidas'),
          ),
        ],
      ),
    );
  }

  Widget _tarjetaItem(int indice) {
    final item = _items[indice];
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: item.nombre,
                    decoration: const InputDecoration(
                      labelText: 'Alimento',
                      isDense: true,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Quitar este item',
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() {
                    _items.removeAt(indice).dispose();
                  }),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _campo(item.porcion, 'Porción', 'g')),
                const SizedBox(width: 8),
                Expanded(child: _campo(item.calorias, 'Calorías', 'kcal')),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _campo(item.proteinas, 'Prot.', 'g')),
                const SizedBox(width: 8),
                Expanded(child: _campo(item.carbos, 'Carbos', 'g')),
                const SizedBox(width: 8),
                Expanded(child: _campo(item.grasas, 'Grasas', 'g')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _campo(TextEditingController ctrl, String etiqueta, String sufijo) {
    return TextField(
      controller: ctrl,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: etiqueta,
        suffixText: sufijo,
        isDense: true,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
