import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'tema_provider.dart' show sharedPreferencesProvider;

/// Soporte multi-usuario SIN registro ni contraseñas: hasta 3 "slots".
///
/// La clave del diseño: cada usuario tiene SU PROPIO archivo de base de
/// datos (nutritrack, nutritrack_u2, nutritrack_u3). Cambiar de usuario
/// es simplemente abrir otra base — aislamiento total sin tocar ninguna
/// consulta del resto de la app.
const maxUsuarios = 3;

/// Slot del usuario activo (1, 2 o 3), persistido en SharedPreferences.
class UsuarioActivoNotifier extends Notifier<int> {
  static const _clave = 'usuario_activo';

  @override
  int build() {
    return ref.watch(sharedPreferencesProvider).getInt(_clave) ?? 1;
  }

  Future<void> cambiar(int slot) async {
    assert(slot >= 1 && slot <= maxUsuarios);
    state = slot;
    await ref.read(sharedPreferencesProvider).setInt(_clave, slot);
  }
}

final usuarioActivoProvider = NotifierProvider<UsuarioActivoNotifier, int>(
  UsuarioActivoNotifier.new,
);

/// Nombres de los usuarios existentes, para mostrar en el selector sin
/// tener que abrir las 3 bases de datos. Formato en prefs: ["1|Lautaro"].
class NombresUsuariosNotifier extends Notifier<Map<int, String>> {
  static const _clave = 'usuarios_nombres';

  @override
  Map<int, String> build() {
    final crudo =
        ref.watch(sharedPreferencesProvider).getStringList(_clave) ?? [];
    final nombres = <int, String>{};
    for (final entrada in crudo) {
      final partes = entrada.split('|');
      final slot = int.tryParse(partes.first);
      if (slot != null && partes.length > 1) nombres[slot] = partes[1];
    }
    return nombres;
  }

  Future<void> registrar(int slot, String nombre) async {
    final nuevo = {...state, slot: nombre.isEmpty ? 'Usuario $slot' : nombre};
    state = nuevo;
    await ref.read(sharedPreferencesProvider).setStringList(
          _clave,
          [for (final e in nuevo.entries) '${e.key}|${e.value}'],
        );
  }
}

final nombresUsuariosProvider =
    NotifierProvider<NombresUsuariosNotifier, Map<int, String>>(
  NombresUsuariosNotifier.new,
);
