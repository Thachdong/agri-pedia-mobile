import 'package:json_annotation/json_annotation.dart';

/// Wait before a code can be resent, measured from `AuthHandoff.at`
/// (ui-ux.md §2, §5).
const otpResendCooldown = Duration(minutes: 3);

/// `purpose` of an OTP (`ResendCodeDto`). Auth only.
@JsonEnum(valueField: 'value')
enum OtpPurpose {
  /// Sent at DISTRIBUTOR registration; entered on /auth/activate.
  activateDistributor('ACTIVATE_DISTRIBUTOR'),

  /// Sent by POST /auth/reset-password; entered on /auth/change-password.
  resetPassword('RESET_PASSWORD');

  const OtpPurpose(this.value);

  /// Server value.
  final String value;
}
