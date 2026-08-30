class Categoria {
  final int id;
  final String nombre;
  final String? descripcion;
  final String? imagenUrl;
  final int orden;

  const Categoria({
    required this.id,
    required this.nombre,
    this.descripcion,
    this.imagenUrl,
    required this.orden,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String?,
      imagenUrl: json['imagenUrl'] as String?,
      orden: json['orden'] as int,
    );
  }
}
