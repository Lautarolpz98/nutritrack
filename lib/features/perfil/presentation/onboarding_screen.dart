import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/database.dart';
import '../../../core/modelos/enums.dart';
import '../domain/calculo_energetico.dart';
import 'perfil_providers.dart';

/// Onboarding en dos pasos:
///  1. Formulario con los datos del usuario.
///  2. Resultados calculados (TMB, objetivo calórico ajustable, macros).
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();

  // Controllers de los campos de texto
  final _nombreCtrl = TextEditingController();
  final _edadCtrl = TextEditingController();
  final _pesoCtrl = TextEditingController();
  final _alturaCtrl = TextEditingController();

  // Selecciones
  Sexo _sexo = Sexo.masculino;
  NivelActividad _nivel = NivelActividad.moderado;
  Objetivo _objetivo = Objetivo.mantener;

  // Resultados (se llenan al pasar al paso 2)
  double _tmb = 0;
  double _tdee = 0;
  final _caloriasCtrl = TextEditingController();
  final _suenoCtrl = TextEditingController(text: '8');
  int _aguaMl = 0;
  bool _guardando = false;

  @override
  void dispose() {
    _pageController.dispose();
    _nombreCtrl.dispose();
    _edadCtrl.dispose();
    _pesoCtrl.dispose();
    _alturaCtrl.dispose();
    _caloriasCtrl.dispose();
    _suenoCtrl.dispose();
    super.dispose();
  }

  /// Paso 1 → 2: valida el formulario, calcula todo y avanza.
  void _calcular() {
    if (!_formKey.currentState!.validate()) return;

    final peso = double.parse(_pesoCtrl.text.replaceAll(',', '.'));
    final altura = double.parse(_alturaCtrl.text.replaceAll(',', '.'));
    final edad = int.parse(_edadCtrl.text);

    _tmb = calcularTmb(sexo: _sexo, pesoKg: peso, alturaCm: altura, edad: edad);
    _tdee = calcularTdee(_tmb, _nivel);
    final calorias = calcularObjetivoCalorico(_tdee, _objetivo);
    _caloriasCtrl.text = calorias.toString();
    _aguaMl = calcularObjetivoAguaMl(peso);

    setState(() {});
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _guardar() async {
    final calorias = int.tryParse(_caloriasCtrl.text);
    if (calorias == null || calorias < 800) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresá un objetivo calórico válido (mínimo 800 kcal)')),
      );
      return;
    }
    final sueno = double.tryParse(_suenoCtrl.text.replaceAll(',', '.')) ?? 8;

    setState(() => _guardando = true);
    // Los macros se recalculan sobre las calorías que el usuario haya
    // dejado (pudo haberlas editado a mano).
    final macros = calcularMacros(calorias);

    await ref.read(perfilRepositoryProvider).guardarPerfil(
          UserProfilesCompanion.insert(
            nombre: Value(_nombreCtrl.text.trim()),
            edad: int.parse(_edadCtrl.text),
            sexo: _sexo,
            pesoKg: double.parse(_pesoCtrl.text.replaceAll(',', '.')),
            alturaCm: double.parse(_alturaCtrl.text.replaceAll(',', '.')),
            nivelActividad: _nivel,
            objetivo: _objetivo,
            objetivoCalorias: calorias,
            objetivoProteinasG: macros.proteinasG,
            objetivoCarbohidratosG: macros.carbohidratosG,
            objetivoGrasasG: macros.grasasG,
            objetivoAguaMl: _aguaMl,
            objetivoSuenoHoras: Value(sueno),
          ),
        );

    if (mounted) context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tu perfil')),
      body: PageView(
        controller: _pageController,
        // Bloqueamos el swipe manual: se avanza solo con los botones,
        // para asegurar que el formulario esté validado.
        physics: const NeverScrollableScrollPhysics(),
        children: [_paginaFormulario(), _paginaResultados()],
      ),
    );
  }

  // ---------- Paso 1: formulario ----------

  Widget _paginaFormulario() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Contanos sobre vos',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 4),
          const Text('Con estos datos calculamos tus objetivos diarios.'),
          const SizedBox(height: 16),
          TextFormField(
            controller: _nombreCtrl,
            decoration: const InputDecoration(
              labelText: 'Nombre (opcional)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          SegmentedButton<Sexo>(
            segments: [
              for (final s in Sexo.values)
                ButtonSegment(value: s, label: Text(s.etiqueta)),
            ],
            selected: {_sexo},
            onSelectionChanged: (v) => setState(() => _sexo = v.first),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _edadCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Edad',
              suffixText: 'años',
              border: OutlineInputBorder(),
            ),
            validator: (v) {
              final n = int.tryParse(v ?? '');
              if (n == null || n < 10 || n > 120) return 'Edad entre 10 y 120';
              return null;
            },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _pesoCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Peso',
                    suffixText: 'kg',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    final n = double.tryParse((v ?? '').replaceAll(',', '.'));
                    if (n == null || n < 25 || n > 400) return 'Peso inválido';
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _alturaCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Altura',
                    suffixText: 'cm',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    final n = double.tryParse((v ?? '').replaceAll(',', '.'));
                    if (n == null || n < 90 || n > 250) {
                      return 'Altura inválida';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<NivelActividad>(
            initialValue: _nivel,
            decoration: const InputDecoration(
              labelText: 'Nivel de actividad',
              border: OutlineInputBorder(),
            ),
            items: [
              for (final n in NivelActividad.values)
                DropdownMenuItem(
                  value: n,
                  child: Text(n.etiqueta, overflow: TextOverflow.ellipsis),
                ),
            ],
            onChanged: (v) => setState(() => _nivel = v!),
          ),
          const SizedBox(height: 12),
          SegmentedButton<Objetivo>(
            segments: [
              for (final o in Objetivo.values)
                ButtonSegment(value: o, label: Text(o.etiqueta.split(' ').first)),
            ],
            selected: {_objetivo},
            onSelectionChanged: (v) => setState(() => _objetivo = v.first),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _calcular,
            child: const Text('Calcular mis objetivos'),
          ),
        ],
      ),
    );
  }

  // ---------- Paso 2: resultados ----------

  Widget _paginaResultados() {
    final macros = calcularMacros(int.tryParse(_caloriasCtrl.text) ?? 0);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Tus objetivos', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _filaDato('Metabolismo basal (TMB)',
                    '${_tmb.round()} kcal/día'),
                _filaDato('Gasto diario estimado (TDEE)',
                    '${_tdee.round()} kcal/día'),
                _filaDato('Objetivo', _objetivo.etiqueta),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _caloriasCtrl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Objetivo calórico diario (podés ajustarlo)',
            suffixText: 'kcal',
            border: OutlineInputBorder(),
          ),
          // Al editar las calorías, recalculamos los macros en pantalla.
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Macros sugeridos (30/40/30)',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                _filaDato('Proteínas', '${macros.proteinasG.round()} g'),
                _filaDato('Carbohidratos', '${macros.carbohidratosG.round()} g'),
                _filaDato('Grasas', '${macros.grasasG.round()} g'),
                const Divider(),
                _filaDato('Agua', '$_aguaMl ml (~${(_aguaMl / 250).round()} vasos)'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _suenoCtrl,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Objetivo de sueño',
            suffixText: 'horas',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            OutlinedButton(
              onPressed: _guardando
                  ? null
                  : () => _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
              child: const Text('Volver'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton(
                onPressed: _guardando ? null : _guardar,
                child: _guardando
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Guardar y empezar'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _filaDato(String etiqueta, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(etiqueta)),
          Text(valor, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
