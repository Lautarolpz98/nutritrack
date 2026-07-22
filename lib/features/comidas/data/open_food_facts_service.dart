import 'package:dio/dio.dart';

import '../domain/producto_off.dart';

/// Cliente HTTP de Open Food Facts (API pública y gratuita, sin key).
class OpenFoodFactsService {
  OpenFoodFactsService([Dio? dio])
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: 'https://world.openfoodfacts.org',
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
              headers: {
                // OFF pide identificarse con un User-Agent descriptivo.
                'User-Agent': 'NutriTrack - Flutter - version 0.1',
              },
            ));

  final Dio _dio;

  /// Busca un producto por código de barras.
  /// Devuelve null si el producto no está en la base de OFF.
  /// Lanza DioException si hay problemas de red (la maneja el repositorio).
  Future<ProductoOFF?> obtenerProducto(String barcode) async {
    final respuesta = await _dio.get<Map<String, dynamic>>(
      '/api/v2/product/$barcode.json',
      // OFF devuelve 404 cuando el barcode no existe: para nosotros eso
      // no es un error de red, es "producto no encontrado".
      options: Options(
        validateStatus: (status) => status == 200 || status == 404,
      ),
    );

    final datos = respuesta.data;
    if (datos == null) return null;
    return ProductoOFF.desdeRespuestaApi(datos, barcode);
  }
}
