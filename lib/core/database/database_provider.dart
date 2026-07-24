import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../preferencias/usuarios_provider.dart';
import 'database.dart';

/// Provider global de la base de datos DEL USUARIO ACTIVO.
///
/// Como watch() depende del usuario activo, al cambiar de usuario Riverpod
/// cierra la base anterior (onDispose) y abre la del usuario nuevo. Todos
/// los providers que dependen de esta base se recrean en cadena — la app
/// entera "cambia de usuario" sola.
final databaseProvider = Provider<AppDatabase>((ref) {
  final slot = ref.watch(usuarioActivoProvider);
  // El slot 1 conserva el nombre original 'nutritrack' para que los datos
  // de quienes ya usaban la app sigan existiendo tras la actualización.
  final nombre = slot == 1 ? 'nutritrack' : 'nutritrack_u$slot';
  final db = AppDatabase(nombre: nombre);
  ref.onDispose(db.close);
  return db;
});
