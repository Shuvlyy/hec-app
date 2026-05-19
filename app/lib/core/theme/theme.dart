import 'package:flutter/material.dart';
import 'app_design_system.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryBlue,
        brightness: Brightness.light,
        surface: Colors.white,
        onSurface: Colors.black,
        surfaceContainerLow: Colors.white,
        outlineVariant: AppColors.dividerLight,
      ),
      scaffoldBackgroundColor: AppColors.systemGray6Light,
      dividerTheme: const DividerThemeData(color: AppColors.dividerLight, thickness: 1),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.l),
        ),
      ),
      textTheme: base.textTheme.copyWith(
        headlineMedium: AppTypography.headlineMedium.copyWith(color: Colors.black),
        titleLarge: AppTypography.titleLarge.copyWith(color: Colors.black),
        bodyLarge: AppTypography.bodyLarge.copyWith(color: Colors.black),
        bodySmall: AppTypography.bodySmall,
        labelMedium: AppTypography.labelMedium.copyWith(color: AppColors.grayText),
      ),
      extensions: [
        const SemanticColors(
          success: AppColors.successGreen,
          onSuccess: Colors.white,
          warning: AppColors.warningOrange,
          onWarning: Colors.white,
          info: AppColors.primaryBlue,
          onInfo: Colors.white,
        ),
      ],
    );
  }

  static ThemeData get darkTheme {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryBlue,
        brightness: Brightness.dark,
        surface: AppColors.systemGray6Dark,
        onSurface: Colors.white,
        surfaceContainerLow: AppColors.secondarySystemBackgroundDark,
        outlineVariant: AppColors.dividerDark,
      ),
      scaffoldBackgroundColor: Colors.black,
      dividerTheme: const DividerThemeData(color: AppColors.dividerDark, thickness: 1),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.systemGray6Dark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.l),
        ),
      ),
      textTheme: base.textTheme.copyWith(
        headlineMedium: AppTypography.headlineMedium.copyWith(color: Colors.white),
        titleLarge: AppTypography.titleLarge.copyWith(color: Colors.white),
        bodyLarge: AppTypography.bodyLarge.copyWith(color: Colors.white),
        bodySmall: AppTypography.bodySmall,
        labelMedium: AppTypography.labelMedium.copyWith(color: AppColors.grayText),
      ),
      extensions: [
        const SemanticColors(
          success: Color(0xFF81C784),
          onSuccess: Colors.black,
          warning: Color(0xFFFFB74D),
          onWarning: Colors.black,
          info: Color(0xFF64B5F6),
          onInfo: Colors.black,
        ),
      ],
    );
  }
}

class SemanticColors extends ThemeExtension<SemanticColors> {
  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color onWarning;
  final Color info;
  final Color onInfo;

  const SemanticColors({
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.info,
    required this.onInfo,
  });

  @override
  ThemeExtension<SemanticColors> copyWith({
    Color? success,
    Color? onSuccess,
    Color? warning,
    Color? onWarning,
    Color? info,
    Color? onInfo,
  }) {
    return SemanticColors(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
    );
  }

  @override
  ThemeExtension<SemanticColors> lerp(ThemeExtension<SemanticColors>? other, double t) {
    if (other is! SemanticColors) return this;
    return SemanticColors(
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      info: Color.lerp(info, other.info, t)!,
      onInfo: Color.lerp(onInfo, other.onInfo, t)!,
    );
  }
}
