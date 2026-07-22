import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/router.dart';
import 'core/preferencias/tema_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Carga los nombres de días/meses en español para DateFormat
  // (ej: "Martes 21 de julio" en el dashboard).
  await initializeDateFormatting('es');
  // Preferencias simples (tema elegido). Se abre una sola vez acá.
  final prefs = await SharedPreferences.getInstance();

  // ProviderScope es el contenedor raíz de Riverpod: sin él ningún
  // provider funciona. El override inyecta las prefs ya abiertas.
  runApp(ProviderScope(
    overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    child: const NutriTrackApp(),
  ));
}

class NutriTrackApp extends ConsumerWidget {
  const NutriTrackApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'NutriTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
      ),
      // Claro / oscuro / según el sistema: lo decide el provider de tema.
      themeMode: ref.watch(temaProvider),
      routerConfig: router,
    );
  }
}
