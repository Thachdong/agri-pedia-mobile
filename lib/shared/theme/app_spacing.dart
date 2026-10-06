import 'package:flutter/painting.dart';

/// Spacing scale (dp). Use for padding, gaps and margins.
abstract final class AppSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;

  /// Horizontal page gutter.
  static const double page = lg;

  /// Minimum tap target.
  static const double tapTarget = 48;
}

/// Radius scale from `--radius: 0.625rem` (10px) × 0.6 / 0.8 / 1 / 1.4 / 1.8.
abstract final class AppRadius {
  static const double sm = 6;
  static const double md = 8;
  static const double lg = 10;
  static const double xl = 14;
  static const double xxl = 18;
  static const double full = 999;

  static const smAll = BorderRadius.all(Radius.circular(sm));
  static const mdAll = BorderRadius.all(Radius.circular(md));
  static const lgAll = BorderRadius.all(Radius.circular(lg));
  static const xlAll = BorderRadius.all(Radius.circular(xl));
  static const fullAll = BorderRadius.all(Radius.circular(full));

  /// Bottom sheets.
  static const sheetTop = BorderRadius.vertical(top: Radius.circular(xl));
}
