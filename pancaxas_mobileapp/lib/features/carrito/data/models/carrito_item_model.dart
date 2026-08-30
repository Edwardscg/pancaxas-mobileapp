class CarritoItemModelo {
  final int itemId;
  final int productoId;
  final String productoNombre;
  final String? productoImagenUrl;
  final double precioUnitario;
  final int cantidad;
  final double subtotal;
  final bool disponible;

  const CarritoItemModelo({
    required this.itemId,
    required this.productoId,
    required this.productoNombre,
    this.productoImagenUrl,
    required this.precioUnitario,
    required this.cantidad,
    required this.subtotal,
    required this.disponible,
  });

  factory CarritoItemModelo.fromJson(Map<String, dynamic> json) {
    return CarritoItemModelo(
      itemId: json['itemId'] as int,
      productoId: json['productoId'] as int,
      productoNombre: json['productoNombre'] as String,
      productoImagenUrl: json['productoImagenUrl'] as String?,
      precioUnitario: (json['precioUnitario'] as num).toDouble(),
      cantidad: json['cantidad'] as int,
      subtotal: (json['subtotal'] as num).toDouble(),
      disponible: json['disponible'] as bool,
    );
  }
}
