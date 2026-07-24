import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/database/database_provider.dart';
import '../data/pasos_repository.dart';

final pasosRepositoryProvider = Provider<PasosRepository>((ref) {
  return PasosRepository(ref.watch(databaseProvider));
});

/// Estado del contador: sirve para que la UI explique qué pasa cuando
/// no hay datos (sin permiso vs. sin sensor vs. todo ok).
enum EstadoContador { iniciando, activo, sinPermiso, sinSensor }

/// Enciende el contador: pide el permiso de actividad física, se suscribe
/// al sensor y va guardando cada lectura en la base del usuario activo.
///
/// El dashboard lo "watchea" para mantenerlo vivo; los pasos en sí se
/// leen desde pasosDeHoyProvider (que sale de la base de datos).
class ContadorPasosNotifier extends Notifier<EstadoContador> {
  StreamSubscription<StepCount>? _suscripcion;

  @override
  EstadoContador build() {
    // El repositorio depende de la base del usuario activo: si cambia el
    // usuario, este notifier se reconstruye y se re-suscribe solo.
    final repo = ref.watch(pasosRepositoryProvider);
    _iniciar(repo);
    ref.onDispose(() => _suscripcion?.cancel());
    return EstadoContador.iniciando;
  }

  Future<void> _iniciar(PasosRepository repo) async {
    await _suscripcion?.cancel();

    final permiso = await Permission.activityRecognition.request();
    if (!permiso.isGranted) {
      state = EstadoContador.sinPermiso;
      return;
    }

    _suscripcion = Pedometer.stepCountStream.listen(
      (evento) {
        state = EstadoContador.activo;
        repo.procesarLectura(evento.steps);
      },
      // El emulador (y algunos teléfonos viejos) no tienen sensor de pasos.
      onError: (_) => state = EstadoContador.sinSensor,
      cancelOnError: true,
    );
  }
}

final contadorPasosProvider =
    NotifierProvider<ContadorPasosNotifier, EstadoContador>(
  ContadorPasosNotifier.new,
);

/// Pasos de hoy, reactivo desde la base de datos.
final pasosDeHoyProvider = StreamProvider.autoDispose<int>((ref) {
  return ref.watch(pasosRepositoryProvider).observarPasosDeHoy();
});
