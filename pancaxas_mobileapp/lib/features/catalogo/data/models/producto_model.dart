class Producto {
  final int id;
  final String nombre;
  final String? descripcion;
  final double precio;
  final String? imagenUrl;
  final int stock;
  final bool disponible;
  final int categoriaId;
  final String categoriaNombre;

  const Producto({
    required this.id,
    required this.nombre,
    this.descripcion,
    required this.precio,
    this.imagenUrl,
    required this.stock,
    required this.disponible,
    required this.categoriaId,
    required this.categoriaNombre,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String?,
      precio: (json['precio'] as num).toDouble(),
      imagenUrl: json['imagenUrl'] as String?,
      stock: json['stock'] as int,
      disponible: json['disponible'] as bool,
      categoriaId: json['categoriaId'] as int,
      categoriaNombre: json['categoriaNombre'] as String,
    );
  }
}
