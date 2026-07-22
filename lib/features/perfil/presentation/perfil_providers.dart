import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database.dart';
import '../../../core/database/database_provider.dart';
import '../data/perfil_repository.dart';

final perfilRepositoryProvider = Provider<PerfilRepository>((ref) {
  return PerfilRepository(ref.watch(databaseProvider));
});

/// El perfil actual como stream: cualquier pantalla que lo observe se
/// redibuja automáticamente cuando el perfil cambia en la base.
final perfilActualProvider = StreamProvider<UserProfile?>((ref) {
  return ref.watch(perfilRepositoryProvider).observarPerfil();
});
