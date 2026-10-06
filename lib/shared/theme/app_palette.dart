import 'package:flutter/painting.dart';

/// Raw brand colors, 1:1 with `--palette-*` in
/// ../client/src/app/globals.css. Change the brand here only.
///
/// Only theme files read this; widgets use `context.scheme` / `context.colors`.
abstract final class AppPalette {
  static const bgPage = Color(0xFFFFFFFF); // --palette-bg-page
  static const bgSurface = Color(0xFFF3F7F5); // --palette-bg-surface
  static const textMain = Color(0xFF1A2521); // --palette-text-main
  static const textHighlight = Color(0xFFC86D4B); // --palette-text-highlight
  static const btnMain = Color(0xFF1E4D3B); // --palette-btn-main
  static const borderSubtle = Color(0xFFE1EADF); // --palette-border-subtle
  static const bgHighlightSubtle = Color(0xFFFFF4F0); // --palette-bg-highlight-subtle
  static const ratingStar = Color(0xFFB7791F); // --palette-rating-star
  static const ratingStarEmpty = Color(0xFFA9B8AF); // --palette-rating-star-empty

  /// --destructive: oklch(0.577 0.245 27.325)
  static const destructive = Color(0xFFE7000B);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
}
