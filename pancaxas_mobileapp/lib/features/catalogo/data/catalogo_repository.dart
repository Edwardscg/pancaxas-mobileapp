import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import 'models/categoria_model.dart';
import 'models/producto_model.dart';

class CatalogoRepository {
  final DioClient _client;

  CatalogoRepository(this._client);

  Future<List<Categoria>> listarCategorias() async {
    try {
      final response = await _client.dio.get('/categorias');
      return (response.data as List)
          .map((e) => Categoria.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _client.traducirError(e);
    }
  }

  Future<List<Producto>> listarProductos({int? categoriaId}) async {
    try {
      final response = await _client.dio.get('/productos', queryParameters: {
        if (categoriaId != null) 'categoriaId': categoriaId,
      });
      return (response.data as List)
          .map((e) => Producto.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _client.traducirError(e);
    }
  }

  Future<Producto> obtenerDetalle(int productoId) async {
    try {
      final response = await _client.dio.get('/productos/$productoId');
      return Producto.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _client.traducirError(e);
    }
  }

  Future<List<Producto>> buscar(String query) async {
    try {
      final response =
          await _client.dio.get('/productos/buscar', queryParameters: {'q': query});
      return (response.data as List)
          .map((e) => Producto.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _client.traducirError(e);
    }
  }
}
