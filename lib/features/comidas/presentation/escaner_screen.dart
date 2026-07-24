import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../app/appbar_volver.dart';
import '../../../core/database/database_provider.dart';
import '../data/open_food_facts_service.dart';
import '../data/productos_repository.dart';

final productosRepositoryProvider = Provider<ProductosRepository>((ref) {
  return ProductosRepository(
    ref.watch(databaseProvider),
    OpenFoodFactsService(),
  );
});

/// Pantalla del escáner de códigos de barras.
class EscanerScreen extends ConsumerStatefulWidget {
  const EscanerScreen({super.key});

  @override
  ConsumerState<EscanerScreen> createState() => _EscanerScreenState();
}

class _EscanerScreenState extends ConsumerState<EscanerScreen> {
  final _controller = MobileScannerController(
    // Solo formatos de productos (EAN/UPC): evita que lea QRs de casualidad.
    formats: [
      BarcodeFormat.ean13,
      BarcodeFormat.ean8,
      BarcodeFormat.upcA,
      BarcodeFormat.upcE,
    ],
  );

  /// Evita procesar 30 detecciones por segundo del mismo código.
  bool _procesando = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture captura) async {
    if (_procesando) return;
    final barcode = captura.barcodes.firstOrNull?.rawValue;
    if (barcode == null || barcode.isEmpty) return;

    setState(() => _procesando = true);
    await _controller.stop(); // congelamos la cámara mientras buscamos

    final resultado =
        await ref.read(productosRepositoryProvider).buscarPorBarcode(barcode);

    if (!mounted) return;

    // El switch es exhaustivo: si mañana agregamos un caso al sealed class,
    // el compilador nos avisa acá.
    switch (resultado) {
      case ProductoEncontrado(:final producto):
        // pushReplacement: al volver del producto no queremos caer de
        // nuevo en el escáner, sino directo al dashboard.
        context.pushReplacement('/comidas/producto', extra: producto);
      case ProductoNoEncontrado():
        await _reintentar(
            'Producto no encontrado en Open Food Facts.\n'
            'Podés cargarlo manualmente.');
      case SinConexion():
        await _reintentar(
            'Sin conexión a internet.\n'
            'El escáner necesita internet la primera vez que ve un producto.');
      case ErrorBusqueda(:final mensaje):
        await _reintentar(mensaje);
    }
  }

  /// Muestra el error y rearma el escáner para intentar de nuevo.
  Future<void> _reintentar(String mensaje) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje), duration: const Duration(seconds: 3)),
    );
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    await _controller.start();
    setState(() => _procesando = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarConVolver(context, 'Escanear producto'),
      body: Stack(
        children: [
          MobileScanner(controller: _controller, onDetect: _onDetect),
          // Guía visual: un marco en el centro para apuntar al código.
          Center(
            child: Container(
              width: 260,
              height: 140,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white70, width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          if (_procesando)
            Container(
              color: Colors.black54,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 12),
                    Text('Buscando producto...',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Apuntá al código de barras del envase',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
