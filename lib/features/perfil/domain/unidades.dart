/// Conversión de unidades de peso. El peso SIEMPRE se guarda en kg en la
/// base de datos; la unidad elegida solo cambia cómo se muestra y se carga.
library;

const _kgPorLb = 0.45359237; // definición exacta de la libra

double kgALb(double kg) => kg / _kgPorLb;

double lbAKg(double lb) => lb * _kgPorLb;

/// Convierte un valor ingresado por el usuario (en su unidad) a kg.
double aKg(double valor, String unidad) =>
    unidad == 'lb' ? lbAKg(valor) : valor;

/// Convierte kg al valor a mostrar en la unidad del usuario.
double desdeKg(double kg, String unidad) => unidad == 'lb' ? kgALb(kg) : kg;

/// Texto listo para mostrar: "80.5 kg" o "177.5 lb".
String formatearPeso(double kg, String unidad) =>
    '${desdeKg(kg, unidad).toStringAsFixed(1)} $unidad';
