import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_ux/core/error/error_messages.dart';
import 'package:ui_ux/core/router/routes.dart';
import 'package:ui_ux/core/utils/validators.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';
import 'package:ui_ux/features/auth/presentation/auth_validators.dart';
import 'package:ui_ux/features/auth/presentation/controllers/auth_handoff_provider.dart';
import 'package:ui_ux/features/auth/presentation/controllers/change_password_form_input.dart';
import 'package:ui_ux/features/auth/presentation/controllers/confirm_password_reset_controller.dart';
import 'package:ui_ux/features/auth/presentation/controllers/resend_code_controller.dart';
import 'package:ui_ux/shared/controllers/countdown_controller.dart';
import 'package:ui_ux/shared/enums/login_type.dart';
import 'package:ui_ux/shared/extensions/theme_context.dart';
import 'package:ui_ux/shared/theme/app_spacing.dart';
import 'package:ui_ux/shared/widgets/app_button.dart';
import 'package:ui_ux/shared/widgets/app_text_field.dart';
import 'package:ui_ux/shared/widgets/countdown_resend.dart';
import 'package:ui_ux/shared/widgets/login_type_tabs.dart';
import 'package:ui_ux/shared/widgets/otp_input.dart';

const _purpose = OtpPurpose.resetPassword;

/// Change-password form (wireframe image-7.png, sections 2–4 minus footer
/// links): EMAIL | PHONE tabs, identifier, Password, Confirm Password,
/// 6-digit code, resend + countdown, CHANGE PASSWORD.
///
/// Init (ui-ux.md §5): handoff from /auth/reset-password → prefill loginType
/// + identifier, resume the 3-min countdown from `at`, focus Password; none →
/// EMAIL, focus the identifier, resend enabled. Last code box → focus
/// CHANGE PASSWORD. Success → /auth/login (the controller clears the
/// handoff). Server errors show under their field
/// ([changePasswordErrorFieldOf]) or under the form.
class ChangePasswordForm extends ConsumerStatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  ConsumerState<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends ConsumerState<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _identifier = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _code = TextEditingController();
  final _identifierFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmFocus = FocusNode();
  final _codeFocus = FocusNode();
  final _submitFocus = FocusNode();

  LoginType _loginType = LoginType.email;
  bool _submitted = false;

  /// Server errors, cleared when the user edits the matching field.
  String? _identifierError;
  String? _codeError;
  String? _formError;
  bool _identifierResetLink = false;
  bool _formResetLink = false;

  @override
  void initState() {
    super.initState();
    unawaited(_initFromHandoff());
  }

  @override
  void dispose() {
    for (final c in [_identifier, _password, _confirmPassword, _code]) {
      c.dispose();
    }
    for (final f in [
      _identifierFocus,
      _passwordFocus,
      _confirmFocus,
      _codeFocus,
      _submitFocus,
    ]) {
      f.dispose();
    }
    super.dispose();
  }

  Future<void> _initFromHandoff() async {
    final handoff = await ref
        .read(authHandoffProvider(_purpose).future)
        .catchError((Object _) => null);
    if (!mounted) return;
    if (handoff == null) {
      _identifierFocus.requestFocus();
      return;
    }
    setState(() {
      _loginType = handoff.loginType;
      _identifier.text = handoff.identifier;
    });
    ref
        .read(countdownControllerProvider(_purpose.value).notifier)
        .start(otpResendCooldown, from: handoff.at);
    _passwordFocus.requestFocus();
  }

  /// Spec: switching tab sets loginType, swaps validation and clears input.
  void _changeLoginType(LoginType type) {
    if (type == _loginType) return;
    setState(() {
      _loginType = type;
      _identifier.clear();
      _identifierError = null;
      _identifierResetLink = false;
    });
    _identifierFocus.requestFocus();
  }

  void _clearServerErrors() {
    _identifierError = null;
    _codeError = null;
    _formError = null;
    _identifierResetLink = false;
    _formResetLink = false;
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _submitted = true;
      _clearServerErrors();
    });
    if (!_formKey.currentState!.validate()) return;

    final input = ChangePasswordFormInput(
      loginType: _loginType,
      identifier: _identifier.text,
      password: _password.text,
      code: _code.text,
    );
    await ref
        .read(confirmPasswordResetControllerProvider.notifier)
        .submit(input.toRequest());
  }

  /// Only the identifier is needed to resend; other fields may be empty.
  Future<void> _resend() async {
    final identifierError = AuthValidators.identifier(_loginType)(
      _identifier.text,
    );
    setState(() {
      _clearServerErrors();
      _identifierError = identifierError;
    });
    if (identifierError != null) {
      _identifierFocus.requestFocus();
      return;
    }
    await ref
        .read(resendCodeControllerProvider(_purpose).notifier)
        .resend(loginType: _loginType, identifier: _identifier.text.trim());
  }

  void _onChanged() {
    ref.read(countdownControllerProvider(_purpose.value).notifier).stop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đổi mật khẩu thành công. Vui lòng đăng nhập lại.'),
      ),
    );
    context.go(Routes.login);
  }

  void _onResent() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã gửi lại mã xác thực.')));
    _code.clear();
    _codeFocus.requestFocus();
  }

  void _onError(Object error) {
    final message = errorMessageOf(error);
    final field = changePasswordErrorFieldOf(error);
    setState(() {
      switch (field) {
        case ChangePasswordErrorField.identifier:
          _identifierError = message;
          _identifierResetLink = field.showResetLink;
          _identifierFocus.requestFocus();
        case ChangePasswordErrorField.code:
          _codeError = message;
          _codeFocus.requestFocus();
        case ChangePasswordErrorField.consumed:
        case ChangePasswordErrorField.form:
          _formError = message;
          _formResetLink = field.showResetLink;
      }
    });
  }

  void _listenWrite(
    AsyncValue<void>? previous,
    AsyncValue<void> next, {
    required VoidCallback onSuccess,
  }) {
    if (previous?.isLoading != true) return;
    switch (next) {
      case AsyncError(:final error):
        _onError(error);
      case AsyncData():
        onSuccess();
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    ref
      ..listen(
        confirmPasswordResetControllerProvider,
        (previous, next) => _listenWrite(previous, next, onSuccess: _onChanged),
      )
      ..listen(
        resendCodeControllerProvider(_purpose),
        (previous, next) => _listenWrite(previous, next, onSuccess: _onResent),
      );
    final isChanging = ref
        .watch(confirmPasswordResetControllerProvider)
        .isLoading;
    final isResending = ref
        .watch(resendCodeControllerProvider(_purpose))
        .isLoading;
    final remaining = ref.watch(countdownControllerProvider(_purpose.value));
    final busy = isChanging || isResending;
    const gap = SizedBox(height: AppSpacing.md);

    return Form(
      key: _formKey,
      autovalidateMode: _submitted
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: LoginTypeTabs(
              value: _loginType,
              onChanged: _changeLoginType,
              enabled: !busy,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            label: _loginType.identifierLabel,
            hint: _loginType == LoginType.email
                ? 'ban@example.com'
                : '0901 234 567',
            controller: _identifier,
            focusNode: _identifierFocus,
            validator: AuthValidators.identifier(_loginType),
            errorText: _identifierError,
            keyboardType: _loginType == LoginType.email
                ? TextInputType.emailAddress
                : TextInputType.phone,
            autofillHints: [
              if (_loginType == LoginType.email)
                AutofillHints.email
              else
                AutofillHints.telephoneNumber,
            ],
            textInputAction: TextInputAction.next,
            enabled: !busy,
            onChanged: (_) {
              if (_identifierError != null) {
                setState(() {
                  _identifierError = null;
                  _identifierResetLink = false;
                });
              }
            },
            onFieldSubmitted: (_) => _passwordFocus.requestFocus(),
          ),
          if (_identifierResetLink)
            const Align(
              alignment: AlignmentDirectional.centerStart,
              child: _ResetPasswordLink(),
            ),
          gap,
          AppTextField(
            label: 'Mật khẩu mới',
            hint: '8–128 ký tự',
            controller: _password,
            focusNode: _passwordFocus,
            obscure: true,
            validator: Validators.password,
            autofillHints: const [AutofillHints.newPassword],
            textInputAction: TextInputAction.next,
            enabled: !busy,
            onFieldSubmitted: (_) => _confirmFocus.requestFocus(),
          ),
          gap,
          AppTextField(
            label: 'Xác nhận mật khẩu',
            controller: _confirmPassword,
            focusNode: _confirmFocus,
            obscure: true,
            validator: AuthValidators.confirmPassword(() => _password.text),
            textInputAction: TextInputAction.next,
            enabled: !busy,
            onFieldSubmitted: (_) => _codeFocus.requestFocus(),
          ),
          gap,
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Text('Mã xác thực', style: context.text.titleSmall),
          ),
          OtpInput(
            length: AuthValidators.otpCodeLength,
            controller: _code,
            focusNode: _codeFocus,
            validator: AuthValidators.otpCode,
            errorText: _codeError,
            enabled: !busy,
            onChanged: (_) {
              if (_codeError != null) setState(() => _codeError = null);
            },
            onCompleted: (_) => _submitFocus.requestFocus(),
          ),
          const SizedBox(height: AppSpacing.sm),
          CountdownResend(
            remaining: remaining,
            onResend: isChanging ? null : _resend,
            isSending: isResending,
          ),
          const SizedBox(height: AppSpacing.xl),
          if (_formError case final error?)
            _FormError(message: error, showResetLink: _formResetLink),
          AppButton(
            label: 'CHANGE PASSWORD',
            onPressed: isResending ? null : _submit,
            isLoading: isChanging,
            focusNode: _submitFocus,
            expand: true,
          ),
        ],
      ),
    );
  }
}

/// Link to request a new reset code (OTP_NOT_FOUND, OTP_ALREADY_CONSUMED).
class _ResetPasswordLink extends StatelessWidget {
  const _ResetPasswordLink();

  @override
  Widget build(BuildContext context) => AppButton(
    label: 'Yêu cầu mã mới',
    variant: AppButtonVariant.text,
    size: AppButtonSize.small,
    onPressed: () => context.go(Routes.resetPassword),
  );
}

/// Server error under the form; OTP_ALREADY_CONSUMED adds a reset link.
class _FormError extends StatelessWidget {
  const _FormError({required this.message, required this.showResetLink});

  final String message;
  final bool showResetLink;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
    child: Semantics(
      liveRegion: true,
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: AppSpacing.xs,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: context.text.bodyMedium?.copyWith(
              color: context.scheme.error,
            ),
          ),
          if (showResetLink) const _ResetPasswordLink(),
        ],
      ),
    ),
  );
}
