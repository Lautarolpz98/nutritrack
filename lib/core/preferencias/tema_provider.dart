import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferences se abre de forma asíncrona, así que lo cargamos en
/// main() ANTES de arrancar la app y lo inyectamos acá con un override.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Se inyecta en main() con overrideWithValue');
});

/// Notifier: la forma moderna de Riverpod para estado que cambia.
/// Guarda el tema elegido y lo persiste en SharedPreferences.
class TemaNotifier extends Notifier<ThemeMode> {
  static const _clave = 'tema';

  @override
  ThemeMode build() {
    final guardado = ref.watch(sharedPreferencesProvider).getString(_clave);
    return switch (guardado) {
      'claro' => ThemeMode.light,
      'oscuro' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> cambiar(ThemeMode modo) async {
    state = modo;
    final texto = switch (modo) {
      ThemeMode.light => 'claro',
      ThemeMode.dark => 'oscuro',
      ThemeMode.system => 'sistema',
    };
    await ref.read(sharedPreferencesProvider).setString(_clave, texto);
  }
}

final temaProvider = NotifierProvider<TemaNotifier, ThemeMode>(
  TemaNotifier.new,
);
