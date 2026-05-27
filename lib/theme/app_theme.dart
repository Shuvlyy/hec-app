import 'package:flutter/material.dart';

class AppTheme {
  // Color palette
  static const primaryOrange = Color(0xFFFF8C42);
  static const secondaryAmber = Color(0xFFFFB347);
  static const accentCoral = Color(0xFFFF6B6B);
  static const backgroundColor = Color(0xFFFAF9F6);
  static const surfaceColor = Colors.white;
  static const cardBorderColor = Color(0xFFF7F2ED);

  // Harmonized Font Sizes
  static const double sizeHeading = 24.0;
  static const double sizeTitle = 18.0;
  static const double sizeBody = 16.0;
  static const double sizeCaption = 14.0;

  static ThemeData get light {
    final baseTextTheme = ThemeData.light().textTheme;
    
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryOrange,
        primary: primaryOrange,
        secondary: secondaryAmber,
        error: accentCoral,
        background: backgroundColor,
        surface: surfaceColor,
        onPrimary: Colors.white,
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: primaryOrange),
        titleTextStyle: TextStyle(
          fontSize: sizeTitle,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      textTheme: baseTextTheme.copyWith(
        headlineMedium: baseTextTheme.headlineMedium?.copyWith(
          fontSize: sizeHeading,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        titleLarge: baseTextTheme.titleLarge?.copyWith(
          fontSize: sizeTitle,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          fontSize: sizeBody,
          color: Colors.black87,
        ),
        bodySmall: baseTextTheme.bodySmall?.copyWith(
          fontSize: sizeCaption,
          color: Colors.grey.shade600,
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: cardBorderColor, width: 1),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryOrange,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: sizeBody,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryOrange,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: sizeCaption,
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(fontSize: sizeCaption),
        labelStyle: const TextStyle(fontSize: sizeCaption),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: cardBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: cardBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryOrange, width: 2),
        ),
      ),
    );
  }
}
