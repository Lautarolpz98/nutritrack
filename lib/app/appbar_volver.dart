import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// AppBar con botón de volver GARANTIZADO.
///
/// Flutter muestra la flecha de volver solo si hay algo en la pila de
/// navegación. Si una pantalla quedó como raíz (por ejemplo tras un
/// pushReplacement), la flecha desaparecía. Con este helper la flecha
/// está siempre: si no hay a dónde volver, lleva al dashboard.
AppBar appBarConVolver(
  BuildContext context,
  String titulo, {
  List<Widget>? actions,
  PreferredSizeWidget? bottom,
}) {
  return AppBar(
    title: Text(titulo),
    actions: actions,
    bottom: bottom,
    leading: BackButton(
      onPressed: () {
        if (context.canPop()) {
          context.pop();
        } else {
          context.go('/');
        }
      },
    ),
  );
}
