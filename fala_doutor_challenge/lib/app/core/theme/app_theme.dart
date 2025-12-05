import 'package:fala_doutor_challenge/app/core/theme/color_schemes/dark_color_scheme.dart';
import 'package:fala_doutor_challenge/app/core/theme/color_schemes/light_color_scheme.dart';
import 'package:fala_doutor_challenge/app/core/theme/text_theme/app_text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: LightColorScheme.scheme,
      textTheme: AppTextTheme.textTheme,
      appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return LightColorScheme.scheme.primary;
          }
          return LightColorScheme.scheme.onSurface;
        }),
      ),
      // ... outras configurações
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: DarkColorScheme.scheme,
      textTheme: AppTextTheme.textTheme,
      appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return DarkColorScheme.scheme.tertiary;
          }
          return DarkColorScheme.scheme.onSurface;
        }),
      ), // ... outras configurações
    );
  }
}
