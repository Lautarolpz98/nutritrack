import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/database/database.dart';
import '../../comidas/domain/totales_dia.dart';
import 'historial_providers.dart';

/// Historial: pestaña Calendario (resumen de un día) y pestaña Gráficos
/// (calorías, peso y sueño de los últimos 7/30 días).
class HistorialScreen extends ConsumerStatefulWidget {
  const HistorialScreen({super.key});

  @override
  ConsumerState<HistorialScreen> createState() => _HistorialScreenState();
}

class _HistorialScreenState extends ConsumerState<HistorialScreen> {
  DateTime _diaSeleccionado = DateTime.now();
  DateTime _diaEnfocado = DateTime.now();
  int _dias = 7; // rango de la pestaña de gráficos

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Historial'),
          bottom: const TabBar(tabs: [
            Tab(icon: Icon(Icons.calendar_month), text: 'Calendario'),
            Tab(icon: Icon(Icons.insights), text: 'Gráficos'),
          ]),
        ),
        body: TabBarView(
          children: [_tabCalendario(), _tabGraficos()],
        ),
      ),
    );
  }

  // ---------- Pestaña 1: calendario ----------

  Widget _tabCalendario() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: TableCalendar<void>(
            locale: 'es',
            firstDay: DateTime(2024),
            lastDay: DateTime.now(),
            focusedDay: _diaEnfocado,
            selectedDayPredicate: (dia) => isSameDay(dia, _diaSeleccionado),
            onDaySelected: (seleccionado, enfocado) => setState(() {
              _diaSeleccionado = seleccionado;
              _diaEnfocado = enfocado;
            }),
            calendarFormat: CalendarFormat.month,
            availableCalendarFormats: const {CalendarFormat.month: 'Mes'},
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _resumenDelDia(_diaSeleccionado),
      ],
    );
  }

  Widget _resumenDelDia(DateTime dia) {
    final comidas = ref.watch(comidasDeFechaProvider(dia)).value ?? [];
    final ejercicios = ref.watch(ejerciciosDeFechaProvider(dia)).value ?? [];
    final aguaMl = ref.watch(aguaDeFechaProvider(dia)).value ?? 0;
    final sueno = ref.watch(suenoDeFechaProvider(dia)).value;

    final totales = calcularTotales(comidas);
    final kcalEjercicio =
        ejercicios.fold<double>(0, (s, e) => s + e.caloriasQuemadas);
    final fechaBonita = DateFormat("EEEE d 'de' MMMM", 'es').format(dia);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fechaBonita[0].toUpperCase() + fechaBonita.substring(1),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('🔥 ${totales.calorias.round()} kcal consumidas · '
                    'P ${totales.proteinasG.round()} / '
                    'C ${totales.carbohidratosG.round()} / '
                    'G ${totales.grasasG.round()} g'),
                const SizedBox(height: 4),
                Text('🏃 ${kcalEjercicio.round()} kcal quemadas '
                    '(${ejercicios.length} actividades)'),
                const SizedBox(height: 4),
                Text('💧 $aguaMl ml de agua'),
                const SizedBox(height: 4),
                Text(sueno == null
                    ? '😴 Sin registro de sueño'
                    : '😴 ${sueno.horas.toStringAsFixed(1)} h de sueño'),
              ],
            ),
          ),
        ),
        if (comidas.isNotEmpty) ...[
          const SizedBox(height: 8),
          for (final c in comidas)
            Card(
              margin: const EdgeInsets.symmetric(vertical: 2),
              child: ListTile(
                dense: true,
                title: Text(c.nombre),
                subtitle: Text(c.momento.etiqueta),
                trailing: Text('${c.calorias.round()} kcal'),
              ),
            ),
        ] else
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text('Sin comidas registradas ese día.'),
          ),
      ],
    );
  }

  // ---------- Pestaña 2: gráficos ----------

  Widget _tabGraficos() {
    final resumenAsync = ref.watch(resumenRangoProvider(_dias));

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Center(
          child: SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 7, label: Text('7 días')),
              ButtonSegment(value: 30, label: Text('30 días')),
            ],
            selected: {_dias},
            onSelectionChanged: (v) => setState(() => _dias = v.first),
          ),
        ),
        const SizedBox(height: 16),
        resumenAsync.when(
          loading: () => const Center(
              child: Padding(
            padding: EdgeInsets.all(32),
            child: CircularProgressIndicator(),
          )),
          error: (e, _) => Text('Error: $e'),
          data: (resumen) => Column(
            children: [
              _tarjetaGrafico(
                titulo: '🔥 Calorías por día',
                child: _graficoBarras(resumen.caloriasPorDia,
                    color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 12),
              _tarjetaGrafico(
                titulo: '⚖️ Peso',
                child: resumen.pesos.length < 2
                    ? const Padding(
                        padding: EdgeInsets.all(24),
                        child: Text('Necesitás al menos 2 registros de peso '
                            'en este rango para ver el gráfico.'),
                      )
                    : _graficoPeso(resumen.pesos),
              ),
              const SizedBox(height: 12),
              _tarjetaGrafico(
                titulo: '😴 Horas de sueño',
                child: _graficoBarras(resumen.suenoPorDia,
                    color: Theme.of(context).colorScheme.tertiary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tarjetaGrafico({required String titulo, required Widget child}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titulo, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            SizedBox(height: 180, child: child),
          ],
        ),
      ),
    );
  }

  /// Etiquetas del eje X: primera, media y última fecha del rango.
  Widget _etiquetaFecha(double valor, List<DiaValor> datos) {
    final i = valor.toInt();
    final esBorde =
        i == 0 || i == datos.length - 1 || i == datos.length ~/ 2;
    if (!esBorde || i < 0 || i >= datos.length) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        DateFormat('d/M').format(datos[i].dia),
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  Widget _graficoBarras(List<DiaValor> datos, {required Color color}) {
    return BarChart(
      BarChartData(
        gridData: const FlGridData(drawVerticalLine: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (v, _) => _etiquetaFecha(v, datos),
            ),
          ),
        ),
        barGroups: [
          for (var i = 0; i < datos.length; i++)
            BarChartGroupData(x: i, barRods: [
              BarChartRodData(
                toY: datos[i].valor,
                color: color,
                width: _dias == 7 ? 18 : 6,
                borderRadius: BorderRadius.circular(3),
              ),
            ]),
        ],
      ),
    );
  }

  Widget _graficoPeso(List<WeightEntry> pesos) {
    final tema = Theme.of(context);
    final valores = pesos.map((p) => p.pesoKg);
    final minY = valores.reduce((a, b) => a < b ? a : b) - 1;
    final maxY = valores.reduce((a, b) => a > b ? a : b) + 1;

    return LineChart(
      LineChartData(
        minY: minY,
        maxY: maxY,
        gridData: const FlGridData(drawVerticalLine: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (v, _) {
                final i = v.toInt();
                final esBorde = i == 0 ||
                    i == pesos.length - 1 ||
                    i == pesos.length ~/ 2;
                if (!esBorde || i >= pesos.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(DateFormat('d/M').format(pesos[i].fecha),
                      style: tema.textTheme.bodySmall),
                );
              },
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (var i = 0; i < pesos.length; i++)
                FlSpot(i.toDouble(), pesos[i].pesoKg),
            ],
            isCurved: true,
            color: tema.colorScheme.primary,
            barWidth: 3,
            dotData: FlDotData(show: pesos.length <= 15),
            belowBarData: BarAreaData(
              show: true,
              color: tema.colorScheme.primary.withValues(alpha: 0.15),
            ),
          ),
        ],
      ),
    );
  }
}
