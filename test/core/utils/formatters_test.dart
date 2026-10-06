import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/core/utils/formatters.dart';

void main() {
  test('price groups thousands with dots and rounds', () {
    expect(Formatters.price(0), '0 ₫');
    expect(Formatters.price(999), '999 ₫');
    expect(Formatters.price(1000), '1.000 ₫');
    expect(Formatters.price(1250000), '1.250.000 ₫');
    expect(Formatters.price(1250000.6), '1.250.001 ₫');
  });

  test('distanceKm: meters under 1 km, one decimal with comma', () {
    expect(Formatters.distanceKm(0.85), '850 m');
    expect(Formatters.distanceKm(2.43), '2,4 km');
    expect(Formatters.distanceKm(3), '3 km');
    expect(Formatters.distanceKm(2.96), '3 km');
  });

  group('relativeTime', () {
    final now = DateTime(2026, 10, 6, 12);
    String ago(Duration d) =>
        Formatters.relativeTime(now.subtract(d), now: now);

    test('buckets', () {
      expect(ago(const Duration(seconds: 30)), 'vừa xong');
      expect(ago(const Duration(minutes: 5)), '5 phút trước');
      expect(ago(const Duration(hours: 3)), '3 giờ trước');
      expect(ago(const Duration(days: 2)), '2 ngày trước');
      expect(ago(const Duration(days: 65)), '2 tháng trước');
      expect(ago(const Duration(days: 400)), '1 năm trước');
    });

    test('future time reads as just now', () {
      expect(
        Formatters.relativeTime(now.add(const Duration(minutes: 2)), now: now),
        'vừa xong',
      );
    });
  });

  test('countdown mm:ss, negative clamps to 00:00', () {
    expect(Formatters.countdown(const Duration(seconds: 95)), '01:35');
    expect(Formatters.countdown(const Duration(minutes: 3)), '03:00');
    expect(Formatters.countdown(const Duration(seconds: -5)), '00:00');
  });
}
