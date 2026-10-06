import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

part 'auth_handoff.freezed.dart';
part 'auth_handoff.g.dart';

/// Data passed from register → activate and reset-password →
/// change-password (CLAUDE.md decision 1). [at] = when the code was sent;
/// the resend countdown (3 min) is computed from it.
@freezed
abstract class AuthHandoff with _$AuthHandoff {
  const factory AuthHandoff({
    required LoginType loginType,
    required String identifier,
    required DateTime at,
    required OtpPurpose purpose,
  }) = _AuthHandoff;

  factory AuthHandoff.fromJson(Map<String, dynamic> json) =>
      _$AuthHandoffFromJson(json);
}
