import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Tema visual centralizado. Todas las pantallas usan estos estilos
/// en vez de definir colores/tamaños sueltos, para mantener consistencia
/// con los prototipos.
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.marron,
        primary: AppColors.marron,
        secondary: AppColors.dorado,
        surface: AppColors.superficie,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: AppColors.fondo,
    );

    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.crema,
        foregroundColor: AppColors.textoPrincipal,
        elevation: 0,
        centerTitle: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.marron,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.superficie,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borde),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borde),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.marron, width: 1.5),
        ),
      ),
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.textoPrincipal,
        displayColor: AppColors.textoPrincipal,
      ),
    );
  }
}
