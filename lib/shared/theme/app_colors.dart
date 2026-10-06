import 'package:flutter/material.dart';
import 'package:ui_ux/shared/theme/app_palette.dart';

/// Semantic tokens that have no `ColorScheme` slot.
///
/// Web token → Flutter:
/// | globals.css            | Flutter                         |
/// |------------------------|---------------------------------|
/// | --background           | scheme.surface                  |
/// | --foreground           | scheme.onSurface                |
/// | --surface (+ card)     | scheme.surfaceContainer         |
/// | --primary(-foreground) | scheme.primary / onPrimary      |
/// | --destructive          | scheme.error                    |
/// | --border-subtle/--input| scheme.outline                  |
/// | --highlight(-fg)       | colors.highlight / onHighlight  |
/// | --highlight-subtle     | colors.highlightSubtle          |
/// | --rating(-muted)       | colors.rating / ratingMuted     |
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.highlight,
    required this.onHighlight,
    required this.highlightSubtle,
    required this.onHighlightSubtle,
    required this.rating,
    required this.ratingMuted,
  });

  static const light = AppColors(
    highlight: AppPalette.textHighlight,
    onHighlight: AppPalette.white,
    highlightSubtle: AppPalette.bgHighlightSubtle,
    onHighlightSubtle: AppPalette.textHighlight,
    rating: AppPalette.ratingStar,
    ratingMuted: AppPalette.ratingStarEmpty,
  );

  /// Accent: links, active tab indicator, focus ring, highlighted borders.
  final Color highlight;
  final Color onHighlight;

  /// Soft accent background (selected row, badges).
  final Color highlightSubtle;
  final Color onHighlightSubtle;

  /// Filled / empty rating stars (graphics, not text).
  final Color rating;
  final Color ratingMuted;

  @override
  AppColors copyWith({
    Color? highlight,
    Color? onHighlight,
    Color? highlightSubtle,
    Color? onHighlightSubtle,
    Color? rating,
    Color? ratingMuted,
  }) => AppColors(
    highlight: highlight ?? this.highlight,
    onHighlight: onHighlight ?? this.onHighlight,
    highlightSubtle: highlightSubtle ?? this.highlightSubtle,
    onHighlightSubtle: onHighlightSubtle ?? this.onHighlightSubtle,
    rating: rating ?? this.rating,
    ratingMuted: ratingMuted ?? this.ratingMuted,
  );

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      highlight: Color.lerp(highlight, other.highlight, t)!,
      onHighlight: Color.lerp(onHighlight, other.onHighlight, t)!,
      highlightSubtle: Color.lerp(highlightSubtle, other.highlightSubtle, t)!,
      onHighlightSubtle: Color.lerp(
        onHighlightSubtle,
        other.onHighlightSubtle,
        t,
      )!,
      rating: Color.lerp(rating, other.rating, t)!,
      ratingMuted: Color.lerp(ratingMuted, other.ratingMuted, t)!,
    );
  }
}
