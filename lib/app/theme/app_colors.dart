import 'package:flutter/material.dart';

/// The central color palette used throughout the application.
///
/// This class cannot be instantiated — it serves solely
/// as a container for static color constants.
class AppColors {
  AppColors._();

  /// The deepest background (behind the modals, the ‘phone screen’ border).
  static const Color backgroundDeep = Color(0xFF050309);

  /// Main screen background.
  static const Color background = Color(0xFF0A0710);

  /// A subtly raised surface.
  static const Color surface = Color(0xFF0D0A14);

  /// Tabs, form fields, list rows.
  static const Color surfaceRaised = Color(0xFF17121F);

  /// Active elements / hover / top layer.
  static const Color surfaceHighest = Color(0xFF1F1830);

  /// Main focus: buttons, interactive elements, links, highlights.
  static const Color primary = Color(0xFFCB69F5);

  /// Deep purple: gradients, glow backgrounds, radial gradient backgrounds.
  static const Color primaryDeep = Color(0xFF6C1AE4);

  /// State hover/pressed brighter than `primary`.
  static const Color primaryHover = Color(0xFFDFA6FA);

  /// Body text, headings.
  static const Color textPrimary = Color(0xFFF3EEFA);

  /// Secondary text.
  static const Color textSecondary = Color(0xFFB8ADC9);

  /// Descriptions, metadata, captions (most commonly gray).
  static const Color textMuted = Color(0xFF9A8FB0);

  /// Disabled elements, placeholders.
  static const Color textDisabled = Color(0xFF6E6482);

  /// Confirmation, "connected" status.
  static const Color success = Color(0xFF4ADE80);

  /// Text against a backdrop of success.
  static const Color successSoft = Color(0xFFA7EBC0);

  /// Warnings, time lock, expiring invitation.
  static const Color warning = Color(0xFFF5B040);

  /// Text on a warning background.
  static const Color warningSoft = Color(0xFFF5D89A);

  /// Errors, permanent lockup, destructive action.
  static const Color error = Color(0xFFFF5050);

  /// Text on the error background.
  static const Color errorSoft = Color(0xFFFF7A7A);

  /// Gentle separators.
  static const Color borderSubtle = Color.fromRGBO(255, 255, 255, 0.06);

  /// Default borders for cards and fields.
  static const Color borderDefault = Color.fromRGBO(255, 255, 255, 0.08);

  /// Border around the active element.
  static const Color borderAccent = Color.fromRGBO(203, 105, 245, 0.22);

  /// Focus, selection.
  static const Color borderAccentStrong = Color.fromRGBO(203, 105, 245, 0.35);
}
