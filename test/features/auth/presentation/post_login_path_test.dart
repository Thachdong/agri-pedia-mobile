import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/features/auth/presentation/post_login_path.dart';

import '../../../fixtures/auth_fixtures.dart';

void main() {
  group('safeFromPath', () {
    test('in-app paths kept, with query', () {
      expect(safeFromPath('/'), '/');
      expect(safeFromPath('/profile/u-9'), '/profile/u-9');
      expect(safeFromPath('/chat?room=1'), '/chat?room=1');
    });

    test('null / empty / relative → null', () {
      expect(safeFromPath(null), isNull);
      expect(safeFromPath(''), isNull);
      expect(safeFromPath('profile/1'), isNull);
    });

    test('external URLs → null', () {
      expect(safeFromPath('//evil.com'), isNull);
      expect(safeFromPath('//evil.com/path'), isNull);
      expect(safeFromPath(r'/\evil.com'), isNull);
      expect(safeFromPath('https://evil.com'), isNull);
      expect(safeFromPath('javascript:alert(1)'), isNull);
    });

    test('/auth and /auth/* → null (would loop to login)', () {
      expect(safeFromPath('/auth'), isNull);
      expect(safeFromPath('/auth/login'), isNull);
      expect(safeFromPath('/auth/register?x=1'), isNull);
      expect(safeFromPath('/authors'), '/authors');
    });
  });

  group('postLoginPath', () {
    test('safe from wins over role', () {
      expect(postLoginPath(distributorUser, '/chat'), '/chat');
      expect(postLoginPath(farmerUser, '/chat'), '/chat');
    });

    test('no / unsafe from → DISTRIBUTOR to own profile, FARMER home', () {
      expect(postLoginPath(distributorUser, null), '/profile/u-1');
      expect(postLoginPath(distributorUser, '//evil.com'), '/profile/u-1');
      expect(postLoginPath(farmerUser, null), '/');
      expect(postLoginPath(farmerUser, '/auth/login'), '/');
    });
  });
}
