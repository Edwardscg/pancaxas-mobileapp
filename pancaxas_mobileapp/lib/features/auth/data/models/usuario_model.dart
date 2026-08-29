enum RolUsuario { cliente, admin }

RolUsuario rolDesdeTexto(String value) {
  switch (value.toUpperCase()) {
    case 'ADMIN':
      return RolUsuario.admin;
    case 'CLIENTE':
    default:
      return RolUsuario.cliente;
  }
}

/// Refleja AuthResponse.java del backend (sin el token, que se maneja aparte).
class Usuario {
  final int id;
  final String nombre;
  final String correo;
  final RolUsuario rol;

  const Usuario({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.rol,
  });

  factory Usuario.fromAuthJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['usuarioId'] as int,
      nombre: json['nombre'] as String,
      correo: json['correo'] as String,
      rol: rolDesdeTexto(json['rol'] as String),
    );
  }
}
