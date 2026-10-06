import 'package:json_annotation/json_annotation.dart';

/// Media `type` in openapi (media presign, product media, avatar, license).
/// Allowed extensions per type follow entities.md.
@JsonEnum(valueField: 'value')
enum MediaType {
  image('IMAGE', extensions: ['jpg', 'jpeg', 'png', 'webp']),
  video('VIDEO', extensions: ['mp4', 'mov']),
  file('FILE', extensions: ['pdf']);

  const MediaType(this.value, {required this.extensions});

  /// Server value (JSON and query params).
  final String value;
  final List<String> extensions;

  /// Type for a file extension (`.JPG` / `jpg`), or null if not allowed.
  static MediaType? fromExtension(String extension) {
    final ext = extension.toLowerCase().replaceFirst('.', '');
    for (final type in values) {
      if (type.extensions.contains(ext)) return type;
    }
    return null;
  }
}
