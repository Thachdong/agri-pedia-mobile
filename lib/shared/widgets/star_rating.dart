import 'package:flutter/material.dart';
import 'package:ui_ux/shared/extensions/theme_context.dart';
import 'package:ui_ux/shared/theme/app_spacing.dart';

enum StarRatingSize {
  /// Inline in cards and summary rows.
  small(14),

  /// Review items, product detail.
  medium(20),

  /// Picking a star in the review sheets.
  large(36);

  const StarRatingSize(this.dimension);
  final double dimension;
}

/// Five stars, filled with `colors.rating` over `colors.ratingMuted`.
///
/// Display: [value] 0..5, fractional (avgRating 4.3 fills 4 stars + 30%).
/// Input: pass [onChanged]; tapping star n reports n (1..5), each star is a
/// 48dp tap target.
class StarRating extends StatelessWidget {
  const StarRating({
    required this.value,
    super.key,
    this.onChanged,
    this.size = StarRatingSize.small,
  });

  static const max = 5;

  final double value;
  final ValueChanged<int>? onChanged;
  final StarRatingSize size;

  @override
  Widget build(BuildContext context) {
    final rating = value.clamp(0, max).toDouble();
    final onTap = onChanged;

    if (onTap == null) {
      return Semantics(
        label: 'Đánh giá ${rating.toStringAsFixed(1)} trên $max sao',
        excludeSemantics: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < max; i++)
              _Star(fill: (rating - i).clamp(0, 1).toDouble(), size: size),
          ],
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 1; i <= max; i++)
          Semantics(
            button: true,
            selected: i <= rating,
            label: '$i sao',
            excludeSemantics: true,
            child: InkResponse(
              onTap: () => onTap(i),
              radius: AppSpacing.tapTarget / 2,
              child: SizedBox.square(
                dimension: size.dimension < AppSpacing.tapTarget
                    ? AppSpacing.tapTarget
                    : size.dimension,
                child: Center(
                  child: _Star(fill: i <= rating ? 1 : 0, size: size),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _Star extends StatelessWidget {
  const _Star({required this.fill, required this.size});

  /// 0 = empty, 1 = full, in between = partially filled from the left.
  final double fill;
  final StarRatingSize size;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dimension = size.dimension;
    return SizedBox.square(
      dimension: dimension,
      child: Stack(
        children: [
          Icon(Icons.star_rounded, size: dimension, color: colors.ratingMuted),
          if (fill > 0)
            ClipRect(
              child: Align(
                alignment: Alignment.centerLeft,
                widthFactor: fill,
                child: Icon(
                  Icons.star_rounded,
                  size: dimension,
                  color: colors.rating,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
