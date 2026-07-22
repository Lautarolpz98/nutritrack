import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/perfil/presentation/perfil_providers.dart';

/// Pantalla inicial: espera a que cargue el perfil desde la base local y
/// decide a dónde ir: onboarding (si no hay perfil) o dashboard.
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final perfilAsync = ref.watch(perfilActualProvider);

    // Cuando el perfil termina de cargar, navegamos. El postFrameCallback
    // evita navegar en medio de un build (Flutter no lo permite).
    perfilAsync.whenData((perfil) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          context.go(perfil == null ? '/onboarding' : '/');
        }
      });
    });

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
