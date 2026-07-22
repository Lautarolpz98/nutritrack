import 'package:flutter/material.dart';

/// Anillo de progreso de calorías: consumidas vs objetivo.
/// Si te pasás del objetivo, el anillo se pinta de rojo.
class AnilloCalorias extends StatelessWidget {
  const AnilloCalorias({
    super.key,
    required this.consumidas,
    required this.objetivo,
  });

  final double consumidas;
  final int objetivo;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final progreso = objetivo <= 0 ? 0.0 : consumidas / objetivo;
    final pasado = progreso > 1.0;
    final restantes = objetivo - consumidas;

    return SizedBox(
      width: 180,
      height: 180,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            // clamp evita que el anillo dé "más de una vuelta" visualmente
            value: progreso.clamp(0.0, 1.0),
            strokeWidth: 12,
            strokeCap: StrokeCap.round,
            backgroundColor: tema.colorScheme.surfaceContainerHighest,
            color: pasado ? tema.colorScheme.error : tema.colorScheme.primary,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${consumidas.round()}',
                style: tema.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text('de $objetivo kcal', style: tema.textTheme.bodySmall),
              const SizedBox(height: 4),
              Text(
                pasado
                    ? '${(-restantes).round()} de más'
                    : 'quedan ${restantes.round()}',
                style: tema.textTheme.bodySmall?.copyWith(
                  color: pasado
                      ? tema.colorScheme.error
                      : tema.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
