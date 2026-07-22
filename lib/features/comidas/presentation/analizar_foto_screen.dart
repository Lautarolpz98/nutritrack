import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/ia/api_key_storage.dart';
import '../../../core/ia/gemini_api_service.dart';

/// Paso 1 del flujo "foto con IA": sacar/elegir la foto y mandarla a
/// analizar. El resultado se revisa en RevisionFotoScreen.
class AnalizarFotoScreen extends ConsumerStatefulWidget {
  const AnalizarFotoScreen({super.key});

  @override
  ConsumerState<AnalizarFotoScreen> createState() =>
      _AnalizarFotoScreenState();
}

class _AnalizarFotoScreenState extends ConsumerState<AnalizarFotoScreen> {
  final _picker = ImagePicker();
  Uint8List? _fotoBytes;
  bool _analizando = false;

  Future<void> _elegirFoto(ImageSource origen) async {
    try {
      // image_picker comprime por nosotros: máx 1024 px de lado y JPEG
      // calidad 85. Menos bytes = análisis más rápido y barato.
      final foto = await _picker.pickImage(
        source: origen,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (foto == null) return; // canceló
      final bytes = await foto.readAsBytes();
      setState(() => _fotoBytes = bytes);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('No se pudo acceder a la cámara/galería. '
                'Revisá los permisos de la app.')));
      }
    }
  }

  Future<void> _analizar() async {
    final bytes = _fotoBytes;
    if (bytes == null) return;
    setState(() => _analizando = true);

    final resultado =
        await ref.read(geminiApiServiceProvider).analizarFotoComida(bytes);

    if (!mounted) return;
    setState(() => _analizando = false);

    switch (resultado) {
      case ExitoIA(:final datos):
        if (datos.items.isEmpty) {
          _aviso(datos.notas.isEmpty
              ? 'La IA no detectó comida en la foto. Probá con otra toma.'
              : 'Sin comida detectada: ${datos.notas}');
        } else {
          context.pushReplacement('/comidas/foto/revision', extra: datos);
        }
      case SinApiKey():
        _aviso('Configurá tu API key de Gemini en Ajustes primero.');
      case KeyInvalida():
        _aviso('La API key no es válida. Revisala en Ajustes.');
      case SinConexionIA():
        _aviso('Sin conexión a internet. El análisis de fotos necesita '
            'internet.');
      case RateLimitIA():
        _aviso('Llegaste al límite gratuito de Google por ahora. '
            'Esperá un minuto y probá de nuevo.');
      case RespuestaNoParseable():
        _aviso('La IA devolvió una respuesta rara. Probá de nuevo.');
      case ErrorIA(:final mensaje):
        _aviso(mensaje);
    }
  }

  void _aviso(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(mensaje), duration: const Duration(seconds: 4)));
  }

  @override
  Widget build(BuildContext context) {
    final hayKey = ref.watch(apiKeyProvider).value?.isNotEmpty == true;

    return Scaffold(
      appBar: AppBar(title: const Text('Foto con IA')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (!hayKey)
            Card(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                        'Para analizar fotos necesitás una API key de '
                        'Gemini (gratis). Se configura una sola vez.'),
                    const SizedBox(height: 8),
                    FilledButton(
                      onPressed: () => context.push('/ajustes'),
                      child: const Text('Ir a Ajustes'),
                    ),
                  ],
                ),
              ),
            ),
          if (_fotoBytes != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.memory(_fotoBytes!, height: 280, fit: BoxFit.cover),
            ),
            const SizedBox(height: 16),
          ],
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed:
                      _analizando ? null : () => _elegirFoto(ImageSource.camera),
                  icon: const Icon(Icons.photo_camera),
                  label: const Text('Sacar foto'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _analizando
                      ? null
                      : () => _elegirFoto(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Galería'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed:
                (_fotoBytes == null || _analizando || !hayKey) ? null : _analizar,
            icon: _analizando
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.auto_awesome),
            label: Text(_analizando ? 'Analizando...' : 'Analizar con IA'),
          ),
          const SizedBox(height: 12),
          Text(
            'La IA estima los valores mirando la foto: son aproximados y '
            'podés corregirlos antes de guardar.',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
