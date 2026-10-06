/// Form field validator: returns a Vietnamese message, or null when valid.
typedef Validator = String? Function(String? value);

/// Reusable rules mirroring the server DTO constraints.
/// Feature-only rules live in the feature (mb-form).
abstract final class Validators {
  static final _email = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  static final _phoneSeparators = RegExp(r'[\s.\-()]');
  static final _vnPhone = RegExp(r'^(\+84|84|0)\d{9}$');
  static final _digits = RegExp(r'^\d+$');

  static const passwordMinLength = 8;
  static const passwordMaxLength = 128;

  static Validator required([String message = 'Vui lòng nhập thông tin']) =>
      (v) => (v == null || v.trim().isEmpty) ? message : null;

  static String? email(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Vui lòng nhập email';
    return _email.hasMatch(v) ? null : 'Email không hợp lệ';
  }

  /// VN number: `+84|84|0` + 9 digits; spaces, `.`, `-`, `(`, `)` allowed.
  static String? vnPhone(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Vui lòng nhập số điện thoại';
    final normalized = v.replaceAll(_phoneSeparators, '');
    return _vnPhone.hasMatch(normalized) ? null : 'Số điện thoại không hợp lệ';
  }

  /// Not trimmed: spaces are part of a password.
  static String? password(String? value) {
    final v = value ?? '';
    if (v.isEmpty) return 'Vui lòng nhập mật khẩu';
    if (v.length < passwordMinLength) {
      return 'Mật khẩu tối thiểu $passwordMinLength ký tự';
    }
    if (v.length > passwordMaxLength) {
      return 'Mật khẩu tối đa $passwordMaxLength ký tự';
    }
    return null;
  }

  /// Equal to another field (confirm password).
  static Validator matches(String Function() other, String message) =>
      (v) => v == other() ? null : message;

  /// Numeric code of exactly [length] digits.
  static Validator otp({int length = 6}) => (value) {
    final v = value?.trim() ?? '';
    if (v.length != length || !_digits.hasMatch(v)) {
      return 'Vui lòng nhập đủ $length chữ số';
    }
    return null;
  };

  static Validator maxLength(int max, [String? message]) =>
      (v) => (v != null && v.trim().length > max)
      ? (message ?? 'Tối đa $max ký tự')
      : null;

  /// First failing message of [validators].
  static Validator compose(List<Validator> validators) => (v) {
    for (final validate in validators) {
      final error = validate(v);
      if (error != null) return error;
    }
    return null;
  };
}
