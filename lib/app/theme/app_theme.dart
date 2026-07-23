import 'package:flutter/material.dart';
import 'package:winkchat/app/theme/app_colors.dart';
import 'package:winkchat/app/theme/app_typography.dart';

/// Application theme, assembled from the design tokens.
///
/// WinkChat ships in dark mode only (see docs/DESIGN_SYSTEM.md §1),
/// so a single [ThemeData] is exposed.
class AppTheme {
  AppTheme._();

  /// The one and only theme of the application.
  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Manrope',
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: _colorScheme,
    textTheme: _textTheme,
  );

  static const ColorScheme _colorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: AppColors.backgroundDeep,
    secondary: AppColors.primaryDeep,
    onSecondary: AppColors.textPrimary,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    error: AppColors.error,
    onError: AppColors.textPrimary,
  );

  static TextTheme get _textTheme =>
      const TextTheme(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        headlineLarge: AppTypography.headlineLarge,
        headlineMedium: AppTypography.headlineMedium,
        titleLarge: AppTypography.titleLarge,
        titleMedium: AppTypography.titleMedium,
        titleSmall: AppTypography.titleSmall,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
        labelLarge: AppTypography.labelLarge,
        labelMedium: AppTypography.labelMedium,
        labelSmall: AppTypography.labelSmall,
      ).apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      );
}
