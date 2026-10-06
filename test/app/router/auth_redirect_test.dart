import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/app/router/auth_redirect.dart';
import 'package:ui_ux/features/auth/auth.dart';

import '../../fixtures/auth_fixtures.dart';

void main() {
  Uri at(String location) => Uri.parse(location);

  test('session loading → stay anywhere', () {
    expect(authRedirect(null, at('/auth/login')), isNull);
    expect(authRedirect(null, at('/')), isNull);
  });

  test('guest → public and auth routes allowed', () {
    const guest = Guest();
    expect(authRedirect(guest, at('/')), isNull);
    expect(authRedirect(guest, at('/profile/u-1')), isNull);
    expect(authRedirect(guest, at('/auth/login')), isNull);
    expect(authRedirect(guest, at('/auth/register')), isNull);
  });

  group('logged in on /auth/*', () {
    test('FARMER → home, DISTRIBUTOR → own profile', () {
      expect(
        authRedirect(const Authenticated(farmerUser), at('/auth/login')),
        '/',
      );
      expect(
        authRedirect(const Authenticated(distributorUser), at('/auth/login')),
        '/profile/u-1',
      );
      expect(
        authRedirect(const Authenticated(farmerUser), at('/auth/activate')),
        '/',
      );
    });

    test('safe ?from= wins; unsafe ignored', () {
      expect(
        authRedirect(
          const Authenticated(distributorUser),
          at('/auth/login?from=%2Fchat%3Froom%3D1'),
        ),
        '/chat?room=1',
      );
      expect(
        authRedirect(
          const Authenticated(farmerUser),
          at('/auth/login?from=%2F%2Fevil.com'),
        ),
        '/',
      );
    });
  });

  test('logged in on public routes → stay', () {
    const auth = Authenticated(farmerUser);
    expect(authRedirect(auth, at('/')), isNull);
    expect(authRedirect(auth, at('/profile/u-1')), isNull);
  });
}
