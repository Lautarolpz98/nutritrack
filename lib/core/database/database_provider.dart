import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database.dart';

/// Provider global de la base de datos.
///
/// Riverpod garantiza que se cree UNA sola instancia de AppDatabase y que
/// cualquier parte de la app pueda accederla con ref.watch/ref.read.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  // Cuando la app se cierra, Riverpod llama a este callback y cerramos
  // la conexión de forma prolija.
  ref.onDispose(db.close);
  return db;
});
