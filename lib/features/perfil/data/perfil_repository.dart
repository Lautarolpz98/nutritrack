import 'package:drift/drift.dart';

import '../../../core/database/database.dart';

/// Repositorio del perfil: la única puerta de entrada a la tabla UserProfiles.
///
/// La idea del patrón repositorio es que las pantallas nunca hablen con
/// Drift directamente: si mañana cambiamos la base de datos, solo se toca
/// este archivo.
class PerfilRepository {
  PerfilRepository(this._db);

  final AppDatabase _db;

  /// Devuelve el perfil guardado, o null si todavía no hizo el onboarding.
  Future<UserProfile?> obtenerPerfil() {
    return (_db.select(_db.userProfiles)..limit(1)).getSingleOrNull();
  }

  /// Stream reactivo: emite cada vez que el perfil cambia en la DB.
  /// Ideal para que la UI se actualice sola.
  Stream<UserProfile?> observarPerfil() {
    return (_db.select(_db.userProfiles)..limit(1)).watchSingleOrNull();
  }

  /// Crea o reemplaza el perfil (solo manejamos uno).
  Future<void> guardarPerfil(UserProfilesCompanion perfil) async {
    await _db.transaction(() async {
      final existente = await obtenerPerfil();
      if (existente == null) {
        await _db.into(_db.userProfiles).insert(perfil);
      } else {
        await (_db.update(_db.userProfiles)
              ..where((t) => t.id.equals(existente.id)))
            .write(perfil.copyWith(actualizadoEn: Value(DateTime.now())));
      }
    });
  }
}
