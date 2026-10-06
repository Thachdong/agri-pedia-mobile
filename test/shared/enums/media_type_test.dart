import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/shared/enums/media_type.dart';

void main() {
  test('fromExtension ignores case and leading dot', () {
    expect(MediaType.fromExtension('.JPG'), MediaType.image);
    expect(MediaType.fromExtension('webp'), MediaType.image);
    expect(MediaType.fromExtension('mov'), MediaType.video);
    expect(MediaType.fromExtension('pdf'), MediaType.file);
  });

  test('fromExtension rejects types not in entities.md', () {
    expect(MediaType.fromExtension('gif'), isNull);
    expect(MediaType.fromExtension(''), isNull);
  });
}
