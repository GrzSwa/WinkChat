import 'package:flutter/material.dart';

/// The central typography used throughout the application.
///
/// This class cannot be instantiated — it serves solely
/// as a container for static typography constants.
class AppTypography {
  AppTypography._();

  /// hero na onboardingu
  static const TextStyle displayLarge = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w800,
    fontFamily: 'Manrope',
  );

  /// large numbers, hero section headers
  static const TextStyle displayMedium = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w800,
    fontFamily: 'Manrope',
  );

  /// screen header
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    fontFamily: 'Manrope',
  );

  /// section header
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    fontFamily: 'Manrope',
  );

  /// card titles
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    fontFamily: 'Manrope',
  );

  /// subheadings
  static const TextStyle titleMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    fontFamily: 'Manrope',
  );

  /// subtitles, usernames
  static const TextStyle titleSmall = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    fontFamily: 'Manrope',
  );

  /// highlighted text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: 'Manrope',
  );

  /// main text — the dominant text in the project
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    fontFamily: 'Manrope',
  );

  /// supporting text
  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: 'Manrope',
  );

  /// field labels, chips
  static const TextStyle labelLarge = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    fontFamily: 'Manrope',
  );

  /// metadata, distance, time
  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    fontFamily: 'Manrope',
  );

  /// the smallest signatures
  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    fontFamily: 'Manrope',
  );
}
