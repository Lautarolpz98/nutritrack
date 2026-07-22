import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/ia/gemini_api_service.dart';
import '../../perfil/presentation/perfil_providers.dart';
import '../domain/rutina_sugerida.dart';
import 'ejercicio_providers.dart';

/// Pide a la IA la rutina del día (con el perfil + historial de 7 días)
/// y la muestra como lista de ejercicios.
class RutinaScreen extends ConsumerStatefulWidget {
  const RutinaScreen({super.key});

  @override
  ConsumerState<RutinaScreen> createState() => _RutinaScreenState();
}

class _RutinaScreenState extends ConsumerState<RutinaScreen> {
  bool _cargando = true;
  RutinaSugerida? _rutina;
  String? _error;
  bool _errorEsDeKey = false;

  @override
  void initState() {
    super.initState();
    _pedirRutina();
  }

  Future<void> _pedirRutina() async {
    setState(() {
      _cargando = true;
      _error = null;
      _errorEsDeKey = false;
    });

    final perfil = await ref.read(perfilRepositoryProvider).obtenerPerfil();
    if (perfil == null) {
      setState(() {
        _cargando = false;
        _error = 'Primero completá tu perfil.';
      });
      return;
    }

    final historial =
        await ref.read(ejercicioRepositoryProvider).resumen7Dias();

    final contexto = '- Edad: ${perfil.edad} años\n'
        '- Sexo: ${perfil.sexo.etiqueta}\n'
        '- Peso: ${perfil.pesoKg} kg, altura: ${perfil.alturaCm} cm\n'
        '- Nivel de actividad: ${perfil.nivelActividad.etiqueta}\n'
        '- Objetivo: ${perfil.objetivo.etiqueta}';

    final resultado = await ref.read(geminiApiServiceProvider).sugerirRutina(
          contextoUsuario: contexto,
          historial7Dias: historial,
        );

    if (!mounted) return;
    setState(() {
      _cargando = false;
      switch (resultado) {
        case ExitoIA(:final datos):
          _rutina = datos;
        case SinApiKey():
          _error = 'Para las rutinas con IA necesitás configurar tu API key '
              'de Gemini (gratis).';
          _errorEsDeKey = true;
        case KeyInvalida():
          _error = 'La API key no es válida. Revisala en Ajustes.';
          _errorEsDeKey = true;
        case SinConexionIA():
          _error = 'Sin conexión a internet.';
        case RateLimitIA():
          _error = 'Llegaste al límite gratuito por ahora. '
              'Esperá un minuto y reintentá.';
        case RespuestaNoParseable():
          _error = 'La IA devolvió una respuesta rara. Reintentá.';
        case ErrorIA(:final mensaje):
          _error = mensaje;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rutina sugerida')),
      body: _cargando
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Armando tu rutina del día...'),
                ],
              ),
            )
          : _error != null
              ? _vistaError(context)
              : _vistaRutina(context),
    );
  }

  Widget _vistaError(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sentiment_dissatisfied, size: 48),
            const SizedBox(height: 12),
            Text(_error!, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            if (_errorEsDeKey)
              FilledButton(
                onPressed: () => context.push('/ajustes'),
                child: const Text('Ir a Ajustes'),
              )
            else
              FilledButton.icon(
                onPressed: _pedirRutina,
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _vistaRutina(BuildContext context) {
    final rutina = _rutina!;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(Icons.info_outline),
                SizedBox(width: 8),
                Expanded(
                  child: Text('Sugerencia generada por IA según tu perfil. '
                      'Adaptala a cómo te sientas hoy y consultá a un '
                      'profesional ante cualquier duda.'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < rutina.ejercicios.length; i++)
          _tarjetaEjercicio(context, i + 1, rutina.ejercicios[i]),
        if (rutina.notas.isNotEmpty) ...[
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text('💡 ${rutina.notas}'),
            ),
          ),
        ],
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: _pedirRutina,
          icon: const Icon(Icons.refresh),
          label: const Text('Generar otra rutina'),
        ),
      ],
    );
  }

  Widget _tarjetaEjercicio(
      BuildContext context, int numero, EjercicioSugerido e) {
    // Armamos los "chips" solo con los datos que aplican a este ejercicio.
    final detalles = <String>[
      if (e.series != null && e.repeticiones != null)
        '${e.series} × ${e.repeticiones}'
      else if (e.repeticiones != null)
        '${e.repeticiones} reps',
      if (e.duracionMin != null) '${e.duracionMin} min',
    ];

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 14, child: Text('$numero')),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(e.nombre,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ),
                for (final d in detalles)
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Chip(
                      label: Text(d),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
              ],
            ),
            if (e.descripcion.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(e.descripcion,
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ],
        ),
      ),
    );
  }
}
