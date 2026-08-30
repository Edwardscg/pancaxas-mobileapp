import 'carrito_item_model.dart';

class CarritoModelo {
  final int carritoId;
  final List<CarritoItemModelo> items;
  final double subtotal;
  final int totalItems;

  const CarritoModelo({
    required this.carritoId,
    required this.items,
    required this.subtotal,
    required this.totalItems,
  });

  factory CarritoModelo.fromJson(Map<String, dynamic> json) {
    return CarritoModelo(
      carritoId: json['carritoId'] as int,
      items: (json['items'] as List)
          .map((e) => CarritoItemModelo.fromJson(e as Map<String, dynamic>))
          .toList(),
      subtotal: (json['subtotal'] as num).toDouble(),
      totalItems: json['totalItems'] as int,
    );
  }
}
