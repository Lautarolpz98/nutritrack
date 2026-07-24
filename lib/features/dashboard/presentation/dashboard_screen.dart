import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/database/database.dart';
import '../../../core/modelos/enums.dart';
import '../../comidas/domain/totales_dia.dart';
import '../../comidas/presentation/comidas_providers.dart';
import '../../ejercicio/presentation/ejercicio_providers.dart';
import '../../pasos/domain/calculo_pasos.dart';
import '../../pasos/presentation/pasos_providers.dart';
import '../../perfil/domain/unidades.dart';
import '../../perfil/presentation/perfil_providers.dart';
import '../../sueno/presentation/habitos_providers.dart';
import '../../sueno/presentation/registrar_sueno_sheet.dart';
import 'widgets/anillo_calorias.dart';

/// Pantalla principal: resumen del día de hoy.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final perfilAsync = ref.watch(perfilActualProvider);
    final comidasAsync = ref.watch(comidasDeHoyProvider);
    final totales = ref.watch(totalesDeHoyProvider);

    final fechaBonita = DateFormat("EEEE d 'de' MMMM", 'es').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text('NutriTrack'),
        actions: [
          IconButton(
            tooltip: 'Usuarios',
            icon: const Icon(Icons.people_outline),
            onPressed: () => context.push('/usuarios'),
          ),
          IconButton(
            tooltip: 'Historial',
            icon: const Icon(Icons.calendar_month_outlined),
            onPressed: () => context.push('/historial'),
          ),
          IconButton(
            tooltip: 'Ajustes',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/ajustes'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _menuAgregar(context),
        icon: const Icon(Icons.add),
        label: const Text('Comida'),
      ),
      body: perfilAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (perfil) {
          if (perfil == null) {
            // No debería pasar (el splash redirige), pero por las dudas.
            return const Center(child: Text('Sin perfil'));
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            children: [
              Text(
                // "martes 21 de julio" → "Martes 21 de julio"
                fechaBonita[0].toUpperCase() + fechaBonita.substring(1),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Center(
                child: AnilloCalorias(
                  consumidas: totales.calorias,
                  objetivo: perfil.objetivoCalorias,
                ),
              ),
              const SizedBox(height: 24),
              _tarjetaMacros(context, perfil, totales),
              const SizedBox(height: 12),
              _tarjetasHabitos(context, ref, perfil),
              const SizedBox(height: 16),
              Text('Comidas de hoy',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              comidasAsync.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Error: $e'),
                data: (comidas) => _listaComidas(context, ref, comidas),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Menú inferior con las tres formas de registrar una comida.
  void _menuAgregar(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Registrar manualmente'),
              subtitle: const Text('Escribí nombre, calorías y macros'),
              onTap: () {
                Navigator.pop(ctx);
                context.push('/comidas/agregar');
              },
            ),
            ListTile(
              leading: const Icon(Icons.qr_code_scanner),
              title: const Text('Escanear código de barras'),
              subtitle: const Text('Busca el producto en Open Food Facts'),
              onTap: () {
                Navigator.pop(ctx);
                context.push('/comidas/escanear');
              },
            ),
            ListTile(
              leading: const Icon(Icons.auto_awesome),
              title: const Text('Foto con IA'),
              subtitle: const Text('Sacale una foto al plato y la IA estima '
                  'calorías y macros'),
              onTap: () {
                Navigator.pop(ctx);
                context.push('/comidas/foto');
              },
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Hábitos (agua, ejercicio, sueño, peso) ----------

  Widget _tarjetasHabitos(
      BuildContext context, WidgetRef ref, UserProfile perfil) {
    final aguaMl = ref.watch(aguaDeHoyProvider).value ?? 0;
    final ejercicios = ref.watch(ejerciciosDeHoyProvider).value ?? [];
    final sueno = ref.watch(suenoDeHoyProvider).value;
    final pesos = ref.watch(pesosProvider).value ?? [];

    // Enciende el contador de pasos (pide permiso y escucha el sensor).
    final estadoContador = ref.watch(contadorPasosProvider);
    final pasos = ref.watch(pasosDeHoyProvider).value ?? 0;
    final kcalPasos = caloriasPorPasos(pasos, perfil.pesoKg);

    // Las calorías de los pasos se suman a las quemadas del día.
    final kcalEjercicio =
        ejercicios.fold<double>(0, (s, e) => s + e.caloriasQuemadas) +
            kcalPasos;
    final vasos = (aguaMl / 250).round();
    final vasosObjetivo = (perfil.objetivoAguaMl / 250).ceil();
    final ultimoPeso = pesos.isEmpty ? null : pesos.last.pesoKg;

    final textoPasos = switch (estadoContador) {
      EstadoContador.sinPermiso => 'Sin permiso de actividad',
      EstadoContador.sinSensor => 'Sensor no disponible',
      _ => '$pasos / ${perfil.objetivoPasos} · ~${kcalPasos.round()} kcal',
    };

    return Column(
      children: [
        _tarjetaHabito(
          context,
          emoji: '🚶',
          titulo: 'Pasos de hoy',
          valor: textoPasos,
          onTap: () {},
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _tarjetaHabito(
                context,
                emoji: '💧',
                titulo: 'Agua',
                valor: '$vasos / $vasosObjetivo vasos',
                // Tap suma un vaso; el ícono "-" deshace el último.
                onTap: () =>
                    ref.read(habitosRepositoryProvider).agregarVaso(),
                accionExtra: vasos > 0
                    ? IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        visualDensity: VisualDensity.compact,
                        onPressed: () => ref
                            .read(habitosRepositoryProvider)
                            .quitarUltimoVaso(),
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _tarjetaHabito(
                context,
                emoji: '🏃',
                titulo: 'Ejercicio',
                valor: '${kcalEjercicio.round()} kcal',
                onTap: () => context.push('/ejercicio'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _tarjetaHabito(
                context,
                emoji: '😴',
                titulo: 'Sueño',
                valor: sueno == null
                    ? 'Registrar'
                    : '${sueno.horas.toStringAsFixed(1)} h',
                onTap: () => RegistrarSuenoSheet.mostrar(context),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _tarjetaHabito(
                context,
                emoji: '⚖️',
                titulo: 'Peso',
                valor: ultimoPeso == null
                    ? 'Registrar'
                    : formatearPeso(ultimoPeso, perfil.unidadPeso),
                onTap: () => context.push('/peso'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _tarjetaHabito(
    BuildContext context, {
    required String emoji,
    required String titulo,
    required String valor,
    required VoidCallback onTap,
    Widget? accionExtra,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titulo,
                        style: Theme.of(context).textTheme.bodySmall),
                    Text(valor,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              ?accionExtra,
            ],
          ),
        ),
      ),
    );
  }

  // ---------- Macros ----------

  Widget _tarjetaMacros(
      BuildContext context, UserProfile perfil, TotalesDia totales) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _barraMacro(context, 'Proteínas', totales.proteinasG,
                perfil.objetivoProteinasG),
            const SizedBox(height: 12),
            _barraMacro(context, 'Carbohidratos', totales.carbohidratosG,
                perfil.objetivoCarbohidratosG),
            const SizedBox(height: 12),
            _barraMacro(
                context, 'Grasas', totales.grasasG, perfil.objetivoGrasasG),
          ],
        ),
      ),
    );
  }

  Widget _barraMacro(
      BuildContext context, String nombre, double actual, double objetivo) {
    final progreso = objetivo <= 0 ? 0.0 : (actual / objetivo).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(nombre, style: Theme.of(context).textTheme.bodyMedium),
            Text(
              '${actual.round()} / ${objetivo.round()} g',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progreso,
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  // ---------- Lista de comidas ----------

  Widget _listaComidas(
      BuildContext context, WidgetRef ref, List<FoodEntry> comidas) {
    if (comidas.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Text('Todavía no registraste comidas hoy.\n'
                'Tocá "+ Comida" para agregar la primera. 🍽️'),
          ),
        ),
      );
    }

    // Agrupamos por momento del día respetando el orden del enum
    // (desayuno → almuerzo → cena → snack).
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final momento in MomentoComida.values)
          ..._seccionMomento(context, ref, momento,
              comidas.where((c) => c.momento == momento).toList()),
      ],
    );
  }

  List<Widget> _seccionMomento(BuildContext context, WidgetRef ref,
      MomentoComida momento, List<FoodEntry> comidas) {
    if (comidas.isEmpty) return const [];
    final kcalMomento =
        comidas.fold<double>(0, (suma, c) => suma + c.calorias);
    return [
      Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(momento.etiqueta,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            Text('${kcalMomento.round()} kcal',
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
      for (final comida in comidas)
        Card(
          margin: const EdgeInsets.symmetric(vertical: 3),
          child: ListTile(
            title: Text(comida.nombre),
            subtitle: Text(_subtituloComida(comida)),
            trailing: Text('${comida.calorias.round()} kcal',
                style: const TextStyle(fontWeight: FontWeight.w600)),
            // Tap = editar; mantener apretado = borrar.
            onTap: () => context.push('/comidas/agregar', extra: comida),
            onLongPress: () => _confirmarBorrado(context, ref, comida),
          ),
        ),
    ];
  }

  String _subtituloComida(FoodEntry c) {
    final partes = <String>[
      if (c.porcionGramos != null) '${c.porcionGramos!.round()} g',
      'P ${c.proteinasG.round()} · C ${c.carbohidratosG.round()} · '
          'G ${c.grasasG.round()}',
    ];
    return partes.join(' · ');
  }

  Future<void> _confirmarBorrado(
      BuildContext context, WidgetRef ref, FoodEntry comida) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Borrar comida?'),
        content: Text('Se va a borrar "${comida.nombre}".'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Borrar'),
          ),
        ],
      ),
    );
    if (confirmado == true) {
      await ref.read(comidasRepositoryProvider).eliminar(comida.id);
    }
  }
}
