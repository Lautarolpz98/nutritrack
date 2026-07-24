import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/preferencias/usuarios_provider.dart';

/// Selector de usuarios: hasta 3 perfiles independientes, sin contraseñas.
/// Cada usuario tiene su propia base de datos en el teléfono.
class UsuariosScreen extends ConsumerWidget {
  const UsuariosScreen({super.key});

  Future<void> _elegir(BuildContext context, WidgetRef ref, int slot) async {
    final activo = ref.read(usuarioActivoProvider);
    if (slot != activo) {
      await ref.read(usuarioActivoProvider.notifier).cambiar(slot);
    }
    // El splash decide: si el slot es nuevo (base vacía) va al onboarding,
    // si ya tiene perfil va al dashboard.
    if (context.mounted) context.go('/splash');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activo = ref.watch(usuarioActivoProvider);
    final nombres = ref.watch(nombresUsuariosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Usuarios')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Cada usuario tiene sus propios datos, objetivos e historial, '
            'guardados por separado en este teléfono.',
          ),
          const SizedBox(height: 16),
          for (var slot = 1; slot <= maxUsuarios; slot++)
            _tarjetaUsuario(
              context,
              ref,
              slot: slot,
              nombre: nombres[slot],
              esActivo: slot == activo,
            ),
        ],
      ),
    );
  }

  Widget _tarjetaUsuario(
    BuildContext context,
    WidgetRef ref, {
    required int slot,
    required String? nombre,
    required bool esActivo,
  }) {
    final existe = nombre != null;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: esActivo
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          child: existe
              ? Text(
                  nombre[0].toUpperCase(),
                  style: TextStyle(
                    color: esActivo
                        ? Theme.of(context).colorScheme.onPrimary
                        : null,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const Icon(Icons.person_add_alt),
        ),
        title: Text(existe ? nombre : 'Agregar usuario'),
        subtitle: Text(
          esActivo
              ? 'Usuario actual'
              : existe
                  ? 'Tocá para cambiar'
                  : 'Perfil nuevo desde cero',
        ),
        trailing: esActivo
            ? Icon(Icons.check_circle,
                color: Theme.of(context).colorScheme.primary)
            : null,
        onTap: esActivo ? null : () => _elegir(context, ref, slot),
      ),
    );
  }
}
