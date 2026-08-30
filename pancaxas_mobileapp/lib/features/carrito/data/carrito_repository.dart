import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import 'models/carrito_model.dart';

class CarritoRepository {
  final DioClient _client;

  CarritoRepository(this._client);

  Future<CarritoModelo> obtenerCarrito() async {
    try {
      final response = await _client.dio.get('/carrito');
      return CarritoModelo.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _client.traducirError(e);
    }
  }

  Future<CarritoModelo> agregarProducto({required int productoId, required int cantidad}) async {
    try {
      final response = await _client.dio.post('/carrito/items', data: {
        'productoId': productoId,
        'cantidad': cantidad,
      });
      return CarritoModelo.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _client.traducirError(e);
    }
  }

  Future<CarritoModelo> actualizarCantidad({required int itemId, required int cantidad}) async {
    try {
      final response = await _client.dio.put('/carrito/items/$itemId', data: {
        'cantidad': cantidad,
      });
      return CarritoModelo.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _client.traducirError(e);
    }
  }

  Future<CarritoModelo> eliminarItem(int itemId) async {
    try {
      final response = await _client.dio.delete('/carrito/items/$itemId');
      return CarritoModelo.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _client.traducirError(e);
    }
  }

  Future<void> vaciarCarrito() async {
    try {
      await _client.dio.delete('/carrito');
    } on DioException catch (e) {
      throw _client.traducirError(e);
    }
  }
}
