import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/database.dart';
import '../../../core/modelos/enums.dart';
import 'comidas_providers.dart';

/// Pantalla de confirmación de un producto escaneado: el usuario ajusta
/// la cantidad en gramos y los valores se recalculan con regla de tres
/// (los datos de Open Food Facts vienen POR 100 g).
class ProductoEscaneadoScreen extends ConsumerStatefulWidget {
  const ProductoEscaneadoScreen({super.key, required this.producto});

  final Product producto;

  @override
  ConsumerState<ProductoEscaneadoScreen> createState() =>
      _ProductoEscaneadoScreenState();
}

class _ProductoEscaneadoScreenState
    extends ConsumerState<ProductoEscaneadoScreen> {
  final _cantidadCtrl = TextEditingController(text: '100');
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
  void dispose() {
    _cantidadCtrl.dispose();
    super.dispose();
  }

  double get _gramos =>
      double.tryParse(_cantidadCtrl.text.replaceAll(',', '.')) ?? 0;

  /// Regla de tres: (valor por 100 g) * gramos / 100.
  double _porcion(double valorPor100g) => valorPor100g * _gramos / 100;

  Future<void> _agregar() async {
    if (_gramos <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresá una cantidad válida en gramos')),
      );
      return;
    }
    setState(() => _guardando = true);

    final p = widget.producto;
    await ref.read(comidasRepositoryProvider).agregar(
          FoodEntriesCompanion.insert(
            nombre: p.nombre,
            calorias: _porcion(p.caloriasPor100g),
            proteinasG: Value(_porcion(p.proteinasPor100g)),
            carbohidratosG: Value(_porcion(p.carbohidratosPor100g)),
            grasasG: Value(_porcion(p.grasasPor100g)),
            porcionGramos: Value(_gramos),
            momento: _momento,
            origen: OrigenRegistro.barcode,
            barcode: Value(p.barcode),
            fecha: DateTime.now(),
          ),
        );

    if (mounted) context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.producto;
    return Scaffold(
      appBar: AppBar(title: const Text('Producto escaneado')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.qr_code_scanner),
              title: Text(p.nombre),
              subtitle: Text('Código: ${p.barcode}\n'
                  'Por 100 g: ${p.caloriasPor100g.round()} kcal · '
                  'P ${p.proteinasPor100g.round()} · '
                  'C ${p.carbohidratosPor100g.round()} · '
                  'G ${p.grasasPor100g.round()}'),
              isThreeLine: true,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _cantidadCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: '¿Cuánto comiste?',
              suffixText: 'g',
              border: OutlineInputBorder(),
            ),
            // setState vacío alcanza: al rebuildearse, la tarjeta de abajo
            // recalcula todos los valores con la cantidad nueva.
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 8),
          // Atajos de cantidades típicas
          Wrap(
            spacing: 8,
            children: [
              for (final g in [30, 50, 100, 150, 200])
                ActionChip(
                  label: Text('$g g'),
                  onPressed: () => setState(() => _cantidadCtrl.text = '$g'),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tu porción (${_gramos.round()} g)',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text('🔥 ${_porcion(p.caloriasPor100g).round()} kcal',
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 4),
                  Text('🥩 ${_porcion(p.proteinasPor100g).round()} g proteína · '
                      '🍞 ${_porcion(p.carbohidratosPor100g).round()} g carbos · '
                      '🥑 ${_porcion(p.grasasPor100g).round()} g grasas'),
                ],
              ),
            ),
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
            onPressed: _guardando ? null : _agregar,
            child: _guardando
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Agregar al día'),
          ),
        ],
      ),
    );
  }
}
