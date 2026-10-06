import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_ux/core/error/error_messages.dart';
import 'package:ui_ux/core/router/routes.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';
import 'package:ui_ux/features/auth/presentation/auth_validators.dart';
import 'package:ui_ux/features/auth/presentation/controllers/activate_controller.dart';
import 'package:ui_ux/features/auth/presentation/controllers/activate_form_input.dart';
import 'package:ui_ux/features/auth/presentation/controllers/auth_handoff_provider.dart';
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

const _purpose = OtpPurpose.activateDistributor;

/// Activate form (wireframe image-1.png, sections 2–4 minus footer links):
/// EMAIL | PHONE tabs, identifier, 6-digit code, resend + countdown, ACTIVATE.
///
/// Init (ui-ux.md §2): handoff → prefill loginType + identifier, resume the
/// 3-min countdown from `at`, focus the first code box; none → EMAIL, focus
/// the identifier, resend enabled. Last code box → focus ACTIVATE.
/// Success → /auth/login (the controller clears the handoff). Server errors
/// show under their field ([activateErrorFieldOf]) or under the form.
class ActivateForm extends ConsumerStatefulWidget {
  const ActivateForm({super.key});

  @override
  ConsumerState<ActivateForm> createState() => _ActivateFormState();
}

class _ActivateFormState extends ConsumerState<ActivateForm> {
  final _formKey = GlobalKey<FormState>();
  final _identifier = TextEditingController();
  final _code = TextEditingController();
  final _identifierFocus = FocusNode();
  final _codeFocus = FocusNode();
  final _submitFocus = FocusNode();

  LoginType _loginType = LoginType.email;
  bool _submitted = false;

  /// Server errors, cleared when the user edits the matching field.
  String? _identifierError;
  String? _codeError;
  String? _formError;
  bool _alreadyActivated = false;

  @override
  void initState() {
    super.initState();
    unawaited(_initFromHandoff());
  }

  @override
  void dispose() {
    _identifier.dispose();
    _code.dispose();
    _identifierFocus.dispose();
    _codeFocus.dispose();
    _submitFocus.dispose();
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
    _codeFocus.requestFocus();
  }

  /// Spec: switching tab sets loginType, swaps validation and clears input.
  void _changeLoginType(LoginType type) {
    if (type == _loginType) return;
    setState(() {
      _loginType = type;
      _identifier.clear();
      _identifierError = null;
    });
    _identifierFocus.requestFocus();
  }

  void _clearServerErrors() {
    _identifierError = null;
    _codeError = null;
    _formError = null;
    _alreadyActivated = false;
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _submitted = true;
      _clearServerErrors();
    });
    if (!_formKey.currentState!.validate()) return;

    final input = ActivateFormInput(
      loginType: _loginType,
      identifier: _identifier.text,
      code: _code.text,
    );
    await ref
        .read(activateControllerProvider.notifier)
        .submit(input.toRequest(), loginType: input.loginType);
  }

  /// Only the identifier is needed to resend; the code may be empty.
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

  void _onActivated() {
    ref.read(countdownControllerProvider(_purpose.value).notifier).stop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Kích hoạt tài khoản thành công. Vui lòng đăng nhập.'),
      ),
    );
    context.go(Routes.login);
  }

  void _onResent() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã gửi lại mã kích hoạt.')));
    _code.clear();
    _codeFocus.requestFocus();
  }

  void _onError(Object error) {
    final message = errorMessageOf(error);
    setState(() {
      switch (activateErrorFieldOf(error)) {
        case ActivateErrorField.identifier:
          _identifierError = message;
          _identifierFocus.requestFocus();
        case ActivateErrorField.code:
          _codeError = message;
          _codeFocus.requestFocus();
        case ActivateErrorField.alreadyActivated:
          _formError = 'Tài khoản đã được kích hoạt.';
          _alreadyActivated = true;
        case ActivateErrorField.form:
          _formError = message;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref
      ..listen(activateControllerProvider, (previous, next) {
        if (previous?.isLoading != true) return;
        switch (next) {
          case AsyncError(:final error):
            _onError(error);
          case AsyncData():
            _onActivated();
          default:
        }
      })
      ..listen(resendCodeControllerProvider(_purpose), (previous, next) {
        if (previous?.isLoading != true) return;
        switch (next) {
          case AsyncError(:final error):
            _onError(error);
          case AsyncData():
            _onResent();
          default:
        }
      });
    final isActivating = ref.watch(activateControllerProvider).isLoading;
    final isResending = ref
        .watch(resendCodeControllerProvider(_purpose))
        .isLoading;
    final remaining = ref.watch(countdownControllerProvider(_purpose.value));
    final busy = isActivating || isResending;

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
                setState(() => _identifierError = null);
              }
            },
            onFieldSubmitted: (_) => _codeFocus.requestFocus(),
          ),
          const SizedBox(height: AppSpacing.md),
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Text('Mã kích hoạt', style: context.text.titleSmall),
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
            onResend: isActivating ? null : _resend,
            isSending: isResending,
          ),
          const SizedBox(height: AppSpacing.xl),
          if (_formError case final error?)
            _FormError(message: error, showLoginLink: _alreadyActivated),
          AppButton(
            label: 'ACTIVATE',
            onPressed: isResending ? null : _submit,
            isLoading: isActivating,
            focusNode: _submitFocus,
            expand: true,
          ),
        ],
      ),
    );
  }
}

/// Server error under the form; OTP_ALREADY_CONSUMED adds a login link.
class _FormError extends StatelessWidget {
  const _FormError({required this.message, required this.showLoginLink});

  final String message;
  final bool showLoginLink;

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
          if (showLoginLink)
            AppButton(
              label: 'Đăng nhập',
              variant: AppButtonVariant.text,
              size: AppButtonSize.small,
              onPressed: () => context.go(Routes.login),
            ),
        ],
      ),
    ),
  );
}
