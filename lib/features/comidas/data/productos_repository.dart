import 'package:dio/dio.dart';
import 'package:drift/drift.dart';

import '../../../core/database/database.dart';
import '../domain/producto_off.dart';
import 'open_food_facts_service.dart';

/// Resultado tipado de una búsqueda por barcode. Usamos una clase sellada
/// (sealed): el compilador nos OBLIGA a manejar todos los casos en la UI
/// con un switch, así ninguno queda sin contemplar.
sealed class ResultadoBusqueda {}

class ProductoEncontrado extends ResultadoBusqueda {
  ProductoEncontrado(this.producto, {required this.desdeCache});
  final Product producto; // fila de la tabla Products (Drift)
  final bool desdeCache;
}

class ProductoNoEncontrado extends ResultadoBusqueda {}

class SinConexion extends ResultadoBusqueda {}

class ErrorBusqueda extends ResultadoBusqueda {
  ErrorBusqueda(this.mensaje);
  final String mensaje;
}

/// Orquesta la búsqueda: cache local primero, API después.
class ProductosRepository {
  ProductosRepository(this._db, this._service);

  final AppDatabase _db;
  final OpenFoodFactsService _service;

  Future<ResultadoBusqueda> buscarPorBarcode(String barcode) async {
    // 1) Cache local: si ya lo escaneamos alguna vez, ni tocamos internet.
    final cacheado = await (_db.select(_db.products)
          ..where((t) => t.barcode.equals(barcode)))
        .getSingleOrNull();
    if (cacheado != null) {
      return ProductoEncontrado(cacheado, desdeCache: true);
    }

    // 2) API de Open Food Facts.
    final ProductoOFF? off;
    try {
      off = await _service.obtenerProducto(barcode);
    } on DioException catch (e) {
      final esProblemaDeRed = e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout;
      return esProblemaDeRed
          ? SinConexion()
          : ErrorBusqueda('Error consultando Open Food Facts (${e.type.name})');
    } catch (e) {
      return ErrorBusqueda('Respuesta inesperada: $e');
    }

    if (off == null) return ProductoNoEncontrado();

    // 3) Guardamos en cache para la próxima.
    final companion = ProductsCompanion.insert(
      barcode: off.barcode,
      nombre: off.nombre,
      caloriasPor100g: off.caloriasPor100g,
      proteinasPor100g: Value(off.proteinasPor100g),
      carbohidratosPor100g: Value(off.carbohidratosPor100g),
      grasasPor100g: Value(off.grasasPor100g),
    );
    await _db.into(_db.products).insertOnConflictUpdate(companion);

    final guardado = await (_db.select(_db.products)
          ..where((t) => t.barcode.equals(barcode)))
        .getSingle();
    return ProductoEncontrado(guardado, desdeCache: false);
  }
}
