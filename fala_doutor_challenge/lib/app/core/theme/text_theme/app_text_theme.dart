import 'package:flutter/material.dart';

class AppTextTheme {
  static TextTheme get textTheme {
    return const TextTheme(
      // Display styles
      displayLarge: TextStyle(fontFamily: 'RockSalt', fontSize: 40),
      displayMedium: TextStyle(fontFamily: 'RockSalt', fontSize: 32),
      displaySmall: TextStyle(fontFamily: 'RockSalt', fontSize: 24),

      // Headline styles
      headlineLarge: TextStyle(fontFamily: 'BowlbyOneSC', fontSize: 40),
      headlineMedium: TextStyle(fontFamily: 'BowlbyOneSC', fontSize: 32),
      headlineSmall: TextStyle(fontFamily: 'BowlbyOneSC', fontSize: 24),

      // Title styles
      titleLarge: TextStyle(
        fontFamily: 'BowlbyOne',
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        fontFamily: 'BowlbyOne',
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontFamily: 'BowlbyOne',
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),

      // Label styles
      labelLarge: TextStyle(
        fontFamily: 'BowlbyOneSC',
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        fontFamily: 'BowlbyOneSC',
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        fontFamily: 'BowlbyOneSC',
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),

      // Body styles
      bodyLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 10,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
