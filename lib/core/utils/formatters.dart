/// Vietnamese display formats. Pure functions, no locale package.
abstract final class Formatters {
  /// `1250000` → `1.250.000 ₫`.
  static String price(num value) => '${_groupThousands(value.round())} ₫';

  /// `0.85` → `850 m`, `2.43` → `2,4 km`.
  static String distanceKm(num km) {
    if (km < 1) return '${(km * 1000).round()} m';
    final rounded = (km * 10).round() / 10;
    final text = rounded == rounded.roundToDouble()
        ? rounded.toInt().toString()
        : rounded.toStringAsFixed(1).replaceAll('.', ',');
    return '$text km';
  }

  /// "vừa xong", "5 phút trước", "3 giờ trước", "2 ngày trước",
  /// "4 tháng trước", "1 năm trước".
  static String relativeTime(DateTime time, {DateTime? now}) {
    final diff = (now ?? DateTime.now()).difference(time);
    if (diff.inMinutes < 1) return 'vừa xong';
    if (diff.inHours < 1) return '${diff.inMinutes} phút trước';
    if (diff.inDays < 1) return '${diff.inHours} giờ trước';
    if (diff.inDays < 30) return '${diff.inDays} ngày trước';
    if (diff.inDays < 365) return '${diff.inDays ~/ 30} tháng trước';
    return '${diff.inDays ~/ 365} năm trước';
  }

  /// `Duration(seconds: 95)` → `01:35`.
  static String countdown(Duration d) {
    final total = d.isNegative ? 0 : d.inSeconds;
    final mm = (total ~/ 60).toString().padLeft(2, '0');
    final ss = (total % 60).toString().padLeft(2, '0');
    return '$mm:$ss';
  }

  static String _groupThousands(int value) {
    final digits = value.abs().toString();
    final buffer = StringBuffer(value < 0 ? '-' : '');
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }
}
