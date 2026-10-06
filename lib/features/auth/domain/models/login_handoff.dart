import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

part 'login_handoff.freezed.dart';
part 'login_handoff.g.dart';

/// Account to prefill on /auth/login after a flow that ends there (FARMER
/// register, activate, change-password). No OTP involved, so separate from
/// `AuthHandoff`. Cleared on login success.
@freezed
abstract class LoginHandoff with _$LoginHandoff {
  const factory LoginHandoff({
    required LoginType loginType,
    required String identifier,
  }) = _LoginHandoff;

  factory LoginHandoff.fromJson(Map<String, dynamic> json) =>
      _$LoginHandoffFromJson(json);
}
