import 'package:go_router/go_router.dart';

import '../core/database/database.dart';
import '../features/ajustes/presentation/ajustes_screen.dart';
import '../features/comidas/domain/analisis_foto.dart';
import '../features/comidas/presentation/agregar_comida_screen.dart';
import '../features/comidas/presentation/analizar_foto_screen.dart';
import '../features/comidas/presentation/escaner_screen.dart';
import '../features/comidas/presentation/producto_escaneado_screen.dart';
import '../features/comidas/presentation/revision_foto_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/ejercicio/presentation/agregar_ejercicio_screen.dart';
import '../features/ejercicio/presentation/ejercicio_screen.dart';
import '../features/ejercicio/presentation/rutina_screen.dart';
import '../features/historial/presentation/historial_screen.dart';
import '../features/perfil/presentation/onboarding_screen.dart';
import '../features/perfil/presentation/usuarios_screen.dart';
import '../features/sueno/presentation/peso_screen.dart';
import 'splash_screen.dart';

/// Rutas de la app. A medida que agreguemos features (comidas, escáner,
/// ajustes...) se suman acá.
final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/comidas/agregar',
      // Si la ruta recibe un FoodEntry por "extra", la pantalla abre en
      // modo edición con los campos precargados.
      builder: (context, state) => AgregarComidaScreen(
        comidaExistente: state.extra as FoodEntry?,
      ),
    ),
    GoRoute(
      path: '/comidas/escanear',
      builder: (context, state) => const EscanerScreen(),
    ),
    GoRoute(
      path: '/comidas/producto',
      // Recibe la fila Product (ya cacheada) desde el escáner.
      builder: (context, state) => ProductoEscaneadoScreen(
        producto: state.extra as Product,
      ),
    ),
    GoRoute(
      path: '/comidas/foto',
      builder: (context, state) => const AnalizarFotoScreen(),
    ),
    GoRoute(
      path: '/comidas/foto/revision',
      builder: (context, state) => RevisionFotoScreen(
        analisis: state.extra as AnalisisFoto,
      ),
    ),
    GoRoute(
      path: '/ajustes',
      builder: (context, state) => const AjustesScreen(),
    ),
    GoRoute(
      path: '/ejercicio',
      builder: (context, state) => const EjercicioScreen(),
    ),
    GoRoute(
      path: '/ejercicio/agregar',
      builder: (context, state) => const AgregarEjercicioScreen(),
    ),
    GoRoute(
      path: '/ejercicio/rutina',
      builder: (context, state) => const RutinaScreen(),
    ),
    GoRoute(
      path: '/peso',
      builder: (context, state) => const PesoScreen(),
    ),
    GoRoute(
      path: '/historial',
      builder: (context, state) => const HistorialScreen(),
    ),
    GoRoute(
      path: '/usuarios',
      builder: (context, state) => const UsuariosScreen(),
    ),
  ],
);
