import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/database/database.dart';
import '../../../core/ia/api_key_storage.dart';
import '../../../core/ia/gemini_api_service.dart';
import '../../../core/preferencias/tema_provider.dart';
import '../../historial/domain/csv_export.dart';
import '../../historial/presentation/historial_providers.dart';
import '../../perfil/presentation/perfil_providers.dart';

/// Ajustes: API key de Gemini, unidades, tema, exportar CSV y borrar datos.
class AjustesScreen extends ConsumerStatefulWidget {
  const AjustesScreen({super.key});

  @override
  ConsumerState<AjustesScreen> createState() => _AjustesScreenState();
}

class _AjustesScreenState extends ConsumerState<AjustesScreen> {
  final _keyCtrl = TextEditingController();
  bool _ocultarKey = true;
  bool _probando = false;
  bool _exportando = false;

  @override
  void dispose() {
    _keyCtrl.dispose();
    super.dispose();
  }

  void _aviso(String mensaje) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensaje)));
  }

  Future<void> _guardarKey() async {
    final key = _keyCtrl.text.trim();
    if (key.isEmpty) {
      _aviso('Pegá tu API key primero.');
      return;
    }
    await ref.read(apiKeyStorageProvider).guardar(key);
    // Invalidamos el provider para que toda la app vea la key nueva.
    ref.invalidate(apiKeyProvider);
    _keyCtrl.clear();
    if (mounted) _aviso('API key guardada de forma segura. ✔');
  }

  Future<void> _probarConexion() async {
    // Probamos la key del campo, o la guardada si el campo está vacío.
    var key = _keyCtrl.text.trim();
    if (key.isEmpty) {
      key = await ref.read(apiKeyStorageProvider).leer() ?? '';
    }
    if (key.isEmpty) {
      _aviso('No hay ninguna key para probar.');
      return;
    }

    setState(() => _probando = true);
    final error =
        await ref.read(geminiApiServiceProvider).probarConexion(key);
    setState(() => _probando = false);

    if (mounted) _aviso(error ?? '¡Conexión exitosa! La key funciona. ✅');
  }

  Future<void> _borrarKey() async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Borrar API key?'),
        content: const Text(
            'Las funciones de IA van a dejar de estar disponibles hasta '
            'que cargues una key de nuevo. El resto de la app sigue igual.'),
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
    if (confirmado != true) return;
    await ref.read(apiKeyStorageProvider).borrar();
    ref.invalidate(apiKeyProvider);
    if (mounted) _aviso('API key borrada.');
  }

  // ---------- Exportar CSV ----------

  Future<void> _exportarCsv() async {
    setState(() => _exportando = true);
    try {
      final repo = ref.read(historialRepositoryProvider);

      // Un CSV por entidad, escritos en la carpeta temporal.
      final archivos = <String, String>{
        'comidas.csv': csvComidas(await repo.todasLasComidas()),
        'ejercicio.csv': csvEjercicio(await repo.todosLosEjercicios()),
        'sueno.csv': csvSueno(await repo.todoElSueno()),
        'agua.csv': csvAgua(await repo.todaElAgua()),
        'peso.csv': csvPeso(await repo.todosLosPesos()),
      };

      final dirTemp = await getTemporaryDirectory();
      final rutas = <XFile>[];
      for (final entrada in archivos.entries) {
        final archivo = File('${dirTemp.path}/${entrada.key}');
        await archivo.writeAsString(entrada.value);
        rutas.add(XFile(archivo.path, mimeType: 'text/csv'));
      }

      // Abre el menú de compartir de Android (Drive, mail, WhatsApp...).
      await SharePlus.instance.share(
        ShareParams(files: rutas, text: 'Datos exportados de NutriTrack'),
      );
    } catch (e) {
      if (mounted) _aviso('No se pudo exportar: $e');
    } finally {
      if (mounted) setState(() => _exportando = false);
    }
  }

  // ---------- Borrar todos los datos ----------

  Future<void> _borrarTodo() async {
    // Doble confirmación: esta acción no tiene vuelta atrás.
    final primera = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Borrar TODOS los datos?'),
        content: const Text(
            'Se van a borrar tu perfil, comidas, ejercicio, sueño, agua, '
            'peso y la API key. Esta acción no se puede deshacer.\n\n'
            'Consejo: exportá tus datos a CSV antes.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancelar')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Continuar')),
        ],
      ),
    );
    if (primera != true || !mounted) return;

    final segunda = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Estás seguro/a?'),
        content: const Text('Última confirmación: se borra todo y la app '
            'vuelve a empezar de cero.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('No, cancelar')),
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(ctx).colorScheme.error),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Sí, borrar todo'),
          ),
        ],
      ),
    );
    if (segunda != true || !mounted) return;

    await ref.read(historialRepositoryProvider).borrarTodosLosDatos();
    await ref.read(apiKeyStorageProvider).borrar();
    // Invalidamos todo el estado en memoria y volvemos al onboarding.
    ref.invalidate(apiKeyProvider);
    ref.invalidate(perfilActualProvider);
    if (mounted) context.go('/onboarding');
  }

  @override
  Widget build(BuildContext context) {
    final keyAsync = ref.watch(apiKeyProvider);
    final hayKey = keyAsync.value?.isNotEmpty == true;

    return Scaffold(
      appBar: AppBar(title: const Text('Ajustes')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Inteligencia artificial',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        hayKey ? Icons.check_circle : Icons.cancel,
                        color: hayKey ? Colors.green : Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(hayKey
                            ? 'API key de Gemini configurada'
                            : 'Sin API key: las funciones de IA están '
                                'desactivadas (el resto de la app funciona igual)'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _keyCtrl,
                    obscureText: _ocultarKey,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      labelText: hayKey
                          ? 'Reemplazar API key'
                          : 'Pegá tu API key de Gemini',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(_ocultarKey
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () =>
                            setState(() => _ocultarKey = !_ocultarKey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FilledButton.icon(
                        onPressed: _guardarKey,
                        icon: const Icon(Icons.save),
                        label: const Text('Guardar'),
                      ),
                      OutlinedButton.icon(
                        onPressed: _probando ? null : _probarConexion,
                        icon: _probando
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2))
                            : const Icon(Icons.wifi_tethering),
                        label: const Text('Probar conexión'),
                      ),
                      if (hayKey)
                        OutlinedButton.icon(
                          onPressed: _borrarKey,
                          icon: const Icon(Icons.delete_outline),
                          label: const Text('Borrar'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('¿Cómo consigo una API key gratis?',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 8),
                  const Text(
                    '1. Entrá a aistudio.google.com con tu cuenta de Google.\n'
                    '2. Tocá "Get API key" → "Create API key".\n'
                    '3. Copiá la key y pegala acá arriba.\n\n'
                    'La capa gratuita de Google alcanza de sobra para el uso '
                    'diario de esta app (analizar fotos de tus comidas). '
                    'No hace falta tarjeta de crédito.\n\n'
                    '🔒 Tu key se guarda cifrada en este dispositivo y solo '
                    'se usa para hablar con la API de Google. Nunca se '
                    'comparte con nadie más.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Preferencias', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          _tarjetaPreferencias(context),
          const SizedBox(height: 24),
          Text('Datos', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: _exportando
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.file_download_outlined),
                  title: const Text('Exportar datos a CSV'),
                  subtitle: const Text(
                      'Comidas, ejercicio, sueño, agua y peso en 5 archivos'),
                  onTap: _exportando ? null : _exportarCsv,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.delete_forever_outlined,
                      color: Theme.of(context).colorScheme.error),
                  title: Text('Borrar todos los datos',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.error)),
                  subtitle: const Text('Empieza la app de cero'),
                  onTap: _borrarTodo,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tarjetaPreferencias(BuildContext context) {
    final perfil = ref.watch(perfilActualProvider).value;
    final tema = ref.watch(temaProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Unidad de peso'),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'kg', label: Text('Kilogramos')),
                ButtonSegment(value: 'lb', label: Text('Libras')),
              ],
              selected: {perfil?.unidadPeso ?? 'kg'},
              onSelectionChanged: (v) async {
                // El peso sigue guardado en kg: solo cambia cómo se muestra.
                await ref.read(perfilRepositoryProvider).guardarPerfil(
                    UserProfilesCompanion(unidadPeso: Value(v.first)));
              },
            ),
            const SizedBox(height: 16),
            const Text('Tema'),
            const SizedBox(height: 8),
            SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(
                    value: ThemeMode.system, label: Text('Sistema')),
                ButtonSegment(value: ThemeMode.light, label: Text('Claro')),
                ButtonSegment(value: ThemeMode.dark, label: Text('Oscuro')),
              ],
              selected: {tema},
              onSelectionChanged: (v) =>
                  ref.read(temaProvider.notifier).cambiar(v.first),
            ),
          ],
        ),
      ),
    );
  }
}
