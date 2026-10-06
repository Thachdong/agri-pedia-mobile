import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/features/auth/data/auth_handoff_store.dart';
import 'package:ui_ux/features/auth/domain/models/auth_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';

part 'auth_handoff_provider.g.dart';

/// Handoff saved for [purpose] (register → activate, reset-password →
/// change-password); null when absent. Pages read it once on init to
/// prefill the identifier and resume the resend countdown.
@riverpod
Future<AuthHandoff?> authHandoff(Ref ref, OtpPurpose purpose) =>
    ref.watch(authHandoffStoreProvider).read(purpose);
