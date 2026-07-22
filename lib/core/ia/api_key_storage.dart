import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Guarda la API key de Gemini CIFRADA en el almacenamiento seguro del
/// sistema (Keystore en Android, Keychain en iOS).
///
/// Reglas de oro: la key nunca se loguea, nunca se guarda en la base de
/// datos común y solo viaja a generativelanguage.googleapis.com.
class ApiKeyStorage {
  static const _clave = 'gemini_api_key';
  // FlutterSecureStorage cifra por defecto (Keystore/Keychain), sin config.
  static const _storage = FlutterSecureStorage();

  Future<String?> leer() => _storage.read(key: _clave);

  Future<void> guardar(String apiKey) =>
      _storage.write(key: _clave, value: apiKey.trim());

  Future<void> borrar() => _storage.delete(key: _clave);
}

final apiKeyStorageProvider = Provider<ApiKeyStorage>((ref) {
  return ApiKeyStorage();
});

/// ¿Hay una key guardada? La UI lo usa para habilitar/deshabilitar las
/// funciones de IA. Después de guardar/borrar hay que invalidarlo con
/// ref.invalidate(apiKeyProvider) para que se relea.
final apiKeyProvider = FutureProvider<String?>((ref) {
  return ref.watch(apiKeyStorageProvider).leer();
});
