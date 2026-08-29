/// Configuración del entorno de la app.
///
/// La URL del backend se pasa en tiempo de compilación con --dart-define,
/// para no hardcodear IPs ni URLs de producción en el código fuente.
///
/// Ejecutar con, por ejemplo:
///   flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8080/api
///
/// En Android Studio: Run > Edit Configurations > Additional run args:
///   --dart-define=API_BASE_URL=http://10.0.2.2:8080/api
class AppConfig {
  AppConfig._();

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8080/api',
  );
}
