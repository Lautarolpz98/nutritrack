import 'package:drift/drift.dart';

import '../../../core/database/database.dart';
import '../domain/calculo_pasos.dart';

class PasosRepository {
  PasosRepository(this._db);

  final AppDatabase _db;

  DateTime get _inicioHoy {
    final ahora = DateTime.now();
    return DateTime(ahora.year, ahora.month, ahora.day);
  }

  /// Pasos de hoy como stream (0 si todavía no hay registro).
  Stream<int> observarPasosDeHoy() {
    return (_db.select(_db.stepDays)
          ..where((t) => t.fecha.equals(_inicioHoy)))
        .watchSingleOrNull()
        .map((fila) => fila?.pasos ?? 0);
  }

  /// Pasos de un día puntual (para el historial).
  Future<int> pasosDelDia(DateTime dia) async {
    final inicio = DateTime(dia.year, dia.month, dia.day);
    final fila = await (_db.select(_db.stepDays)
          ..where((t) => t.fecha.equals(inicio)))
        .getSingleOrNull();
    return fila?.pasos ?? 0;
  }

  /// Procesa una lectura cruda del sensor y actualiza el registro de hoy.
  Future<void> procesarLectura(int lectura) async {
    final hoy = _inicioHoy;
    final existente = await (_db.select(_db.stepDays)
          ..where((t) => t.fecha.equals(hoy)))
        .getSingleOrNull();

    final estado = procesarLecturaSensor(
      lectura: lectura,
      pasosGuardadosHoy: existente?.pasos,
      ultimoValorGuardado: existente?.ultimoValorSensor,
    );

    await _db.into(_db.stepDays).insertOnConflictUpdate(
          StepDaysCompanion.insert(
            fecha: hoy,
            pasos: Value(estado.pasosHoy),
            ultimoValorSensor: estado.ultimoValorSensor,
          ),
        );
  }
}
