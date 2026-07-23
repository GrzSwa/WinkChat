/// A scale normalized based on the values used in the project (8/10/12/14 are the most common).
///
/// This class cannot be instantiated — it serves solely
/// as a container for static dimension constants.
class AppDimensions {
  AppDimensions._();

  /// Extra small spacing/size unit — the smallest step in the scale.
  static const double xs = 4;

  /// Small spacing/size unit.
  static const double sm = 8;

  /// Medium spacing/size unit — commonly used as a default gap.
  static const double md = 12;

  /// Base unit of the scale, matching the project's default font size.
  static const double base = 14;

  /// Large spacing/size unit.
  static const double lg = 18;

  /// Extra large spacing/size unit.
  static const double xl = 24;

  /// Double extra large spacing/size unit.
  static const double xxl = 28;

  /// Triple extra large spacing/size unit, used for prominent gaps or sizes.
  static const double xxxl = 44;

  /// Largest unit in the scale, reserved for very large
  /// elements (e.g. big icons, hero spacing).
  static const double huge = 56;

  /// Progress bars, small indicators.
  static const double radiusXs = 3;

  /// Chips, small fields.
  static const double radiusSm = 12;

  /// Form fields.
  static const double radiusMd = 14;

  /// Cards, list rows.
  static const double radiusLg = 16;

  /// Large cards, bottom sheets.
  static const double radiusXl = 20;

  /// Modals.
  static const double radiusXxl = 24;

  /// Buttons (pill-shaped).
  static const double radiusPill = 46;
}
