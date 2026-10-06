import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/core/storage/token_storage.dart';

void main() {
  late TokenStorage storage;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    storage = TokenStorage(const FlutterSecureStorage());
  });

  test('empty → null', () async {
    expect(await storage.read(), isNull);
  });

  test('write / read / clear', () async {
    await storage.write(
      const TokenPair(accessToken: 'acc', refreshToken: 'ref'),
    );
    final pair = await storage.read();
    expect(pair?.accessToken, 'acc');
    expect(pair?.refreshToken, 'ref');

    await storage.clear();
    expect(await storage.read(), isNull);
  });

  test('half-written pair → null', () async {
    FlutterSecureStorage.setMockInitialValues({'auth.access_token': 'acc'});
    expect(await storage.read(), isNull);
  });

  test('toString never exposes tokens', () {
    const pair = TokenPair(accessToken: 'secret-a', refreshToken: 'secret-r');
    expect(pair.toString(), isNot(contains('secret')));
  });
}
