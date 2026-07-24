import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/comidas/domain/analisis_foto.dart';
import '../../features/ejercicio/domain/rutina_sugerida.dart';
import 'api_key_storage.dart';

/// Resultado tipado de cualquier llamada a la IA.
///
/// Es GENÉRICO (`<T>`): el mismo juego de casos de error sirve para el
/// análisis de fotos (T = AnalisisFoto) y para las rutinas de ejercicio
/// (T = RutinaSugerida). Solo el caso de éxito lleva datos.
sealed class ResultadoIA<T> {}

class ExitoIA<T> extends ResultadoIA<T> {
  ExitoIA(this.datos);
  final T datos;
}

class SinApiKey<T> extends ResultadoIA<T> {}

class KeyInvalida<T> extends ResultadoIA<T> {}

class SinConexionIA<T> extends ResultadoIA<T> {}

class RateLimitIA<T> extends ResultadoIA<T> {}

class RespuestaNoParseable<T> extends ResultadoIA<T> {}

class ErrorIA<T> extends ResultadoIA<T> {
  ErrorIA(this.mensaje);
  final String mensaje;
}

/// Servicio central de IA: encapsula TODAS las llamadas a la API de Gemini.
/// Ninguna otra parte de la app arma requests HTTP a la IA.
class GeminiApiService {
  GeminiApiService(this._storage, [Dio? dio])
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: 'https://generativelanguage.googleapis.com',
              connectTimeout: const Duration(seconds: 15),
              // Analizar una imagen o armar una rutina lleva varios segundos.
              receiveTimeout: const Duration(seconds: 60),
            ));

  final ApiKeyStorage _storage;
  final Dio _dio;

  /// Modelo preferido. Si la key del usuario no lo tiene disponible (404),
  /// _descubrirModelo() busca automáticamente uno que sí funcione.
  static const _modeloPreferido = 'gemini-3.5-flash';

  /// Modelo que ya sabemos que funciona con esta key (cache en memoria).
  String? _modeloResuelto;

  static const _promptFoto = '''
Analizá esta foto de un plato de comida. Identificá cada alimento visible y estimá su porción en gramos y sus valores nutricionales PARA ESA PORCIÓN (no por 100 g).

Respondé SOLO con un JSON válido, sin texto adicional, con exactamente este formato:
{"items": [{"nombre": "string", "porcion_estimada_g": 0, "calorias": 0, "proteinas_g": 0, "carbohidratos_g": 0, "grasas_g": 0}], "confianza": "alta|media|baja", "notas": "string"}

Reglas:
- Nombres en español rioplatense.
- Si la foto no muestra comida, devolvé "items": [] y explicá el motivo en "notas".
- En "notas" mencioná cualquier suposición importante (ej: "asumí que la bebida es gaseosa común y no light").
- "confianza" refleja qué tan seguro estás de la estimación en general.''';

  // ---------- API pública ----------

  /// Analiza una foto de comida (bytes JPEG ya comprimidos).
  Future<ResultadoIA<AnalisisFoto>> analizarFotoComida(
      Uint8List jpegBytes) async {
    final r = await _pedirTexto(prompt: _promptFoto, jpegBytes: jpegBytes);
    if (r is! ExitoIA<String>) return _propagarError(r);

    final analisis = AnalisisFoto.desdeTexto(r.datos);
    if (analisis == null) return RespuestaNoParseable();
    return ExitoIA(analisis);
  }

  /// Sugiere la rutina de ejercicios del día según perfil, historial y
  /// dónde va a entrenar la persona (gimnasio o casa).
  Future<ResultadoIA<RutinaSugerida>> sugerirRutina({
    required String contextoUsuario,
    required String historial7Dias,
    required bool enGimnasio,
  }) async {
    final equipamiento = enGimnasio
        ? 'La rutina es para GIMNASIO: hay acceso a máquinas, barras, '
            'discos, mancuernas de todos los pesos y cintas/bicicletas.'
        : 'La rutina es PARA HACER EN CASA con poco o ningún equipamiento: '
            'peso corporal y, como mucho, mancuernas livianas o bandas '
            'elásticas. También sirven actividades como caminar o correr.';

    final prompt = '''
Sos un entrenador personal. Armá una rutina de ejercicio PARA HOY para esta persona:
$contextoUsuario

$equipamiento

Historial de ejercicio de los últimos 7 días:
$historial7Dias

Respondé SOLO con un JSON válido, sin texto adicional, con exactamente este formato:
{"ejercicios": [{"nombre": "string", "series": 0, "repeticiones": 0, "duracion_min": 0, "descripcion": "string"}], "notas": "string"}

Reglas:
- Entre 4 y 8 ejercicios, realistas para el nivel de la persona y coherentes con el equipamiento indicado.
- Usá null en series/repeticiones si no aplican (ej: caminata) y null en duracion_min si no aplica (ej: sentadillas por repeticiones).
- "descripcion" corta: cómo hacerlo y a qué prestarle atención.
- En "notas" poné un consejo general del día (descanso, hidratación, etc.). Español rioplatense.''';

    final r = await _pedirTexto(prompt: prompt);
    if (r is! ExitoIA<String>) return _propagarError(r);

    final rutina = RutinaSugerida.desdeTexto(r.datos);
    if (rutina == null) return RespuestaNoParseable();
    return ExitoIA(rutina);
  }

  /// Request mínimo para validar la key desde Ajustes: lista los modelos
  /// disponibles (no consume tokens). Devuelve null si la key sirve, o un
  /// mensaje de error para mostrar.
  Future<String?> probarConexion(String apiKey) async {
    try {
      await _dio.get<void>(
        '/v1beta/models',
        options: Options(headers: {'x-goog-api-key': apiKey.trim()}),
      );
      return null; // 200 = key válida
    } on DioException catch (e) {
      final codigo = e.response?.statusCode;
      if (codigo == 400 || codigo == 401 || codigo == 403) {
        return 'La API key no es válida. Revisá que la hayas copiado completa.';
      }
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        return 'Sin conexión a internet.';
      }
      return 'Error inesperado (${codigo ?? e.type.name}).';
    }
  }

  // ---------- Internos ----------

  /// Núcleo compartido: manda un prompt (con imagen opcional) y devuelve
  /// el texto crudo de la respuesta, con todo el manejo de errores y el
  /// fallback de modelo.
  Future<ResultadoIA<String>> _pedirTexto({
    required String prompt,
    Uint8List? jpegBytes,
  }) async {
    final apiKey = await _storage.leer();
    if (apiKey == null || apiKey.isEmpty) return SinApiKey();

    Response<Map<String, dynamic>> respuesta;
    try {
      respuesta = await _generarContenido(
          apiKey, _modeloResuelto ?? _modeloPreferido, prompt, jpegBytes);
    } on DioException catch (e) {
      // 404 = el modelo no existe para esta key (Google los rota seguido).
      // Buscamos uno disponible y reintentamos UNA vez.
      if (e.response?.statusCode == 404) {
        final alternativo = await _descubrirModelo(apiKey);
        if (alternativo == null) {
          return ErrorIA('Tu key no tiene ningún modelo compatible '
              'disponible. Probá crear una key nueva en aistudio.google.com.');
        }
        _modeloResuelto = alternativo;
        try {
          respuesta =
              await _generarContenido(apiKey, alternativo, prompt, jpegBytes);
        } on DioException catch (e2) {
          return _mapearError(e2);
        }
      } else {
        return _mapearError(e);
      }
    }

    // Ruta dentro de la respuesta: candidates[0].content.parts[0].text
    final texto = _extraerTexto(respuesta.data);
    if (texto == null) return RespuestaNoParseable();
    return ExitoIA(texto);
  }

  /// Convierte un error de `ResultadoIA<String>` al tipo T que espera el
  /// llamador (los casos de error no llevan datos, solo cambia la T).
  ResultadoIA<T> _propagarError<T>(ResultadoIA<String> r) {
    return switch (r) {
      ExitoIA<String>() =>
        throw StateError('_propagarError recibió un éxito'),
      SinApiKey<String>() => SinApiKey(),
      KeyInvalida<String>() => KeyInvalida(),
      SinConexionIA<String>() => SinConexionIA(),
      RateLimitIA<String>() => RateLimitIA(),
      RespuestaNoParseable<String>() => RespuestaNoParseable(),
      ErrorIA<String>(:final mensaje) => ErrorIA(mensaje),
    };
  }

  /// Hace el POST de generateContent contra un modelo concreto.
  Future<Response<Map<String, dynamic>>> _generarContenido(
      String apiKey, String modelo, String prompt, Uint8List? jpegBytes) {
    return _dio.post<Map<String, dynamic>>(
      '/v1beta/models/$modelo:generateContent',
      options: Options(headers: {
        'x-goog-api-key': apiKey,
        'content-type': 'application/json',
      }),
      data: {
        'contents': [
          {
            'parts': [
              if (jpegBytes != null)
                {
                  'inlineData': {
                    'mimeType': 'image/jpeg',
                    'data': base64Encode(jpegBytes),
                  },
                },
              {'text': prompt},
            ],
          },
        ],
        // Le pedimos a Gemini que la respuesta sea JSON puro: reduce
        // muchísimo la chance de que venga envuelta en markdown.
        'generationConfig': {'responseMimeType': 'application/json'},
      },
    );
  }

  /// Le pregunta a la API qué modelos puede usar esta key y elige el mejor
  /// "flash" estable. Devuelve null si no hay ninguno compatible.
  Future<String?> _descubrirModelo(String apiKey) async {
    final List<dynamic> modelos;
    try {
      final respuesta = await _dio.get<Map<String, dynamic>>(
        '/v1beta/models',
        queryParameters: {'pageSize': 1000},
        options: Options(headers: {'x-goog-api-key': apiKey}),
      );
      modelos = respuesta.data?['models'] as List? ?? const [];
    } on DioException {
      return null;
    }

    // Nos quedamos con los "flash" estables que soporten generateContent.
    final candidatos = <String>[];
    for (final m in modelos) {
      if (m is! Map) continue;
      final nombre = (m['name'] as String? ?? '').replaceFirst('models/', '');
      final metodos = (m['supportedGenerationMethods'] as List?) ?? const [];
      final esUtilizable = metodos.contains('generateContent') &&
          nombre.contains('flash') &&
          !nombre.contains('preview') &&
          !nombre.contains('exp') &&
          !nombre.contains('image') &&
          !nombre.contains('tts');
      if (esUtilizable) candidatos.add(nombre);
    }
    if (candidatos.isEmpty) return null;

    // Preferimos el flash "completo" sobre el "lite", y dentro de cada
    // grupo la versión más nueva (orden alfabético descendente funciona:
    // "gemini-3.6-flash" > "gemini-3.5-flash").
    candidatos.sort((a, b) {
      final aLite = a.contains('lite') ? 1 : 0;
      final bLite = b.contains('lite') ? 1 : 0;
      if (aLite != bLite) return aLite - bLite;
      return b.compareTo(a);
    });
    return candidatos.first;
  }

  ResultadoIA<String> _mapearError(DioException e) {
    final codigo = e.response?.statusCode;
    if (codigo == 400 || codigo == 401 || codigo == 403) {
      // 400 con key mala es lo que devuelve Gemini ("API key not valid").
      final cuerpo = e.response?.data?.toString() ?? '';
      if (codigo != 400 || cuerpo.contains('API key')) return KeyInvalida();
      return ErrorIA('Request rechazado por la API (400).');
    }
    if (codigo == 429) return RateLimitIA();
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return SinConexionIA();
    }
    return ErrorIA('Error de la API (${codigo ?? e.type.name}).');
  }

  String? _extraerTexto(Map<String, dynamic>? datos) {
    if (datos == null) return null;
    try {
      final candidatos = datos['candidates'] as List?;
      final contenido = (candidatos?.first as Map?)?['content'] as Map?;
      final partes = contenido?['parts'] as List?;
      final texto = (partes?.first as Map?)?['text'];
      return texto is String ? texto : null;
    } catch (_) {
      return null;
    }
  }
}

final geminiApiServiceProvider = Provider<GeminiApiService>((ref) {
  return GeminiApiService(ref.watch(apiKeyStorageProvider));
});
