import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ui_ux/shared/extensions/theme_context.dart';

enum AppAvatarSize {
  /// Review list, chat rows.
  small(32),

  /// Header, distributor cards.
  medium(40),

  /// Profile header.
  large(64),

  /// Edit profile.
  xLarge(96);

  const AppAvatarSize(this.dimension);
  final double dimension;
}

/// Round user avatar.
///
/// [url] is a signed media URL (expires, ~1h) or null. The cache key drops
/// the query string so a re-signed URL of the same file hits the cache.
/// No URL, loading or a failed/expired URL → initials of [name].
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    required this.name,
    super.key,
    this.url,
    this.size = AppAvatarSize.medium,
    this.onTap,
  });

  final String? url;

  /// Username; used for initials and the semantics label.
  final String name;
  final AppAvatarSize size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dimension = size.dimension;
    final fallback = _Initials(name: name, dimension: dimension);
    final imageUrl = url;

    final avatar = ClipOval(
      child: SizedBox.square(
        dimension: dimension,
        child: imageUrl == null || imageUrl.isEmpty
            ? fallback
            : CachedNetworkImage(
                imageUrl: imageUrl,
                cacheKey: imageUrl.split('?').first,
                fit: BoxFit.cover,
                memCacheWidth: (dimension * 3).round(),
                placeholder: (_, _) => fallback,
                errorWidget: (_, _, _) => fallback,
              ),
      ),
    );

    return Semantics(
      image: true,
      button: onTap != null,
      label: 'Ảnh đại diện của $name',
      excludeSemantics: true,
      child: onTap == null
          ? avatar
          : InkResponse(onTap: onTap, radius: dimension / 2, child: avatar),
    );
  }
}

class _Initials extends StatelessWidget {
  const _Initials({required this.name, required this.dimension});

  final String name;
  final double dimension;

  @override
  Widget build(BuildContext context) {
    final style = dimension >= AppAvatarSize.large.dimension
        ? context.text.headlineSmall
        : context.text.labelLarge;
    return ColoredBox(
      color: context.colors.highlightSubtle,
      child: Center(
        child: Text(
          _initials(name),
          style: style?.copyWith(color: context.colors.onHighlightSubtle),
        ),
      ),
    );
  }

  /// "Nguyễn Văn An" → "NA", "agri_shop" → "A", "" → "?".
  static String _initials(String name) {
    final words = name.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty);
    if (words.isEmpty) return '?';
    final first = words.first.characters.first;
    final last = words.length > 1 ? words.last.characters.first : '';
    return (first + last).toUpperCase();
  }
}
