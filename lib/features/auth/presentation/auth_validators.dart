import 'package:ui_ux/core/utils/validators.dart';
import 'package:ui_ux/shared/enums/business_type.dart';
import 'package:ui_ux/shared/enums/login_type.dart';
import 'package:ui_ux/shared/enums/user_role.dart';

/// Auth form rules on top of [Validators] (`RegisterUserDto` + api.md §1).
abstract final class AuthValidators {
  static const identifierMaxLength = 255;
  static const usernameMaxLength = 100;
  static const bioMaxLength = 1000;

  /// Digits of an OTP (activate, change-password). Server accepts 4..10 and
  /// sends OTP_LENGTH (default 6); boxes of `OtpInput` use this too.
  static const otpCodeLength = 6;

  /// Email or VN phone depending on the selected tab; ≤ 255.
  static Validator identifier(LoginType loginType) => Validators.compose([
    switch (loginType) {
      LoginType.email => Validators.email,
      LoginType.phone => Validators.vnPhone,
    },
    Validators.maxLength(identifierMaxLength),
  ]);

  /// Exactly [otpCodeLength] digits.
  static final Validator otpCode = Validators.otp(length: otpCodeLength);

  /// Optional (server defaults it to the identifier); empty after trim is
  /// not sent, so only the max length is checked.
  static final Validator username = Validators.maxLength(usernameMaxLength);

  static final Validator bio = Validators.maxLength(bioMaxLength);

  /// Login checks presence only (1..128, `LoginUserDto`): the strength
  /// rule applies when a password is set, not when it is typed to log in.
  static final Validator loginPassword = Validators.compose([
    Validators.required('Vui lòng nhập mật khẩu'),
    Validators.maxLength(Validators.passwordMaxLength),
  ]);

  /// Client only, never sent.
  static Validator confirmPassword(String Function() password) =>
      Validators.compose([
        Validators.required('Vui lòng nhập lại mật khẩu'),
        Validators.matches(password, 'Mật khẩu xác nhận không khớp'),
      ]);

  /// Required for DISTRIBUTOR; ignored for FARMER (sent as null).
  static String? Function(BusinessType?) businessType(UserRole role) =>
      (value) => role == UserRole.distributor && value == null
      ? 'Vui lòng chọn loại hình kinh doanh'
      : null;
}
