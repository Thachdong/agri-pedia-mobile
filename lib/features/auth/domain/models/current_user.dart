import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_ux/shared/enums/business_type.dart';
import 'package:ui_ux/shared/enums/login_type.dart';
import 'package:ui_ux/shared/enums/user_role.dart';

part 'current_user.freezed.dart';

/// The logged-in user, as the session needs it (header, guest vs logged in,
/// role checks). The server stays the authority on permissions.
@freezed
abstract class CurrentUser with _$CurrentUser {
  const factory CurrentUser({
    required String id,
    required LoginType loginType,

    /// Email or phone, per [loginType].
    required String identifier,
    required String username,
    required UserRole role,
    BusinessType? businessType,
    String? avatar,
    String? bio,
  }) = _CurrentUser;
}
