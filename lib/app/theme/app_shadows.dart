import 'package:flutter/material.dart';

/// A glow in the accent color is a distinctive feature of this visual
/// identity — used for active elements and points on the radar.
///
/// This class cannot be instantiated — it serves solely
/// as a container for static shadows and glows constants.
class AppShadows {
  AppShadows._();

  /// Purple accent glow with strong intensity and wide spread,
  /// used to highlight accented elements.
  static const BoxShadow glowAccent = BoxShadow(
    color: Color.fromRGBO(203, 105, 245, 0.9),
    blurRadius: 18,
  );

  /// Softer, more spread-out variant of the accent glow, with reduced opacity.
  static const BoxShadow glowAccentSoft = BoxShadow(
    color: Color.fromRGBO(203, 105, 245, 0.6),
    blurRadius: 30,
  );

  /// Tighter, more subtle variant of the accent glow, with a smaller spread.
  static const BoxShadow glowAccentSubtle = BoxShadow(
    color: Color.fromRGBO(203, 105, 245, 0.8),
    blurRadius: 12,
  );

  /// Deep drop shadow used under elevated surfaces (e.g. modals, cards).
  static const BoxShadow shadowDeep = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.6),
    offset: Offset(0, 30),
    blurRadius: 70,
  );

  /// Dark shadow cast upward, e.g. above a bottom sheet or sticky footer.
  static const BoxShadow shadowSheet = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.5),
    offset: Offset(0, -20),
    blurRadius: 60,
  );
}
