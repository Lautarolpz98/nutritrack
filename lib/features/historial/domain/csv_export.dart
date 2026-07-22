import '../../../core/database/database.dart';

/// Generación de CSV como funciones puras (listas adentro → texto afuera).
///
/// Regla de escapado CSV estándar: si un valor contiene coma, comillas o
/// salto de línea, se envuelve en comillas y las comillas internas se
/// duplican ("").
String generarCsv(List<String> encabezados, List<List<Object?>> filas) {
  final buffer = StringBuffer();
  buffer.writeln(encabezados.map(_escapar).join(','));
  for (final fila in filas) {
    buffer.writeln(fila.map((v) => _escapar(_texto(v))).join(','));
  }
  return buffer.toString();
}

String _texto(Object? v) {
  if (v == null) return '';
  if (v is DateTime) {
    // Formato ISO corto, fácil de abrir en Excel/Sheets.
    return '${v.year}-${_dos(v.month)}-${_dos(v.day)} ${_dos(v.hour)}:${_dos(v.minute)}';
  }
  if (v is double) {
    // Punto decimal siempre (el CSV es independiente del idioma del sistema).
    return v.toStringAsFixed(1);
  }
  return v.toString();
}

String _dos(int n) => n.toString().padLeft(2, '0');

String _escapar(String valor) {
  if (valor.contains(',') || valor.contains('"') || valor.contains('\n')) {
    return '"${valor.replaceAll('"', '""')}"';
  }
  return valor;
}

// ---------- Un CSV por entidad ----------

String csvComidas(List<FoodEntry> comidas) => generarCsv(
      [
        'fecha', 'momento', 'nombre', 'calorias', 'proteinas_g',
        'carbohidratos_g', 'grasas_g', 'porcion_g', 'origen', 'barcode',
      ],
      [
        for (final c in comidas)
          [
            c.fecha, c.momento.name, c.nombre, c.calorias, c.proteinasG,
            c.carbohidratosG, c.grasasG, c.porcionGramos, c.origen.name,
            c.barcode,
          ],
      ],
    );

String csvEjercicio(List<ExerciseEntry> ejercicios) => generarCsv(
      ['fecha', 'tipo', 'duracion_min', 'calorias_quemadas', 'notas'],
      [
        for (final e in ejercicios)
          [e.fecha, e.tipo, e.duracionMin, e.caloriasQuemadas, e.notas],
      ],
    );

String csvSueno(List<SleepEntry> registros) => generarCsv(
      ['fecha', 'horas', 'hora_acostarse', 'hora_levantarse'],
      [
        for (final s in registros)
          [s.fecha, s.horas, s.horaAcostarse, s.horaLevantarse],
      ],
    );

String csvAgua(List<WaterEntry> registros) => generarCsv(
      ['fecha', 'ml'],
      [
        for (final a in registros) [a.fecha, a.ml],
      ],
    );

String csvPeso(List<WeightEntry> registros) => generarCsv(
      ['fecha', 'peso_kg'],
      [
        for (final p in registros) [p.fecha, p.pesoKg],
      ],
    );
