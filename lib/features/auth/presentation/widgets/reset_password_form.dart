import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_ux/core/error/error_messages.dart';
import 'package:ui_ux/core/router/routes.dart';
import 'package:ui_ux/features/auth/presentation/auth_validators.dart';
import 'package:ui_ux/features/auth/presentation/controllers/request_password_reset_controller.dart';
import 'package:ui_ux/features/auth/presentation/controllers/reset_password_form_input.dart';
import 'package:ui_ux/shared/enums/login_type.dart';
import 'package:ui_ux/shared/extensions/theme_context.dart';
import 'package:ui_ux/shared/theme/app_spacing.dart';
import 'package:ui_ux/shared/widgets/app_button.dart';
import 'package:ui_ux/shared/widgets/app_text_field.dart';
import 'package:ui_ux/shared/widgets/login_type_tabs.dart';

/// Reset-password form (wireframe image-3.png, sections 2–4 minus footer
/// links): EMAIL | PHONE tabs, identifier, RESET.
///
/// Init (ui-ux.md §4): EMAIL, focus the identifier. Switching tab clears the
/// input. Success (incl. a still-valid previous code) → /auth/change-password
/// (the controller saves the handoff). Server errors show under the
/// identifier or under the form ([resetPasswordErrorFieldOf]).
class ResetPasswordForm extends ConsumerStatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  ConsumerState<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends ConsumerState<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _identifier = TextEditingController();
  final _identifierFocus = FocusNode();

  LoginType _loginType = LoginType.email;
  bool _submitted = false;

  /// Server errors, cleared when the user edits the identifier or resubmits.
  String? _identifierError;
  String? _formError;
  bool _notActivated = false;

  @override
  void dispose() {
    _identifier.dispose();
    _identifierFocus.dispose();
    super.dispose();
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

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _submitted = true;
      _identifierError = null;
      _formError = null;
      _notActivated = false;
    });
    if (!_formKey.currentState!.validate()) return;

    final input = ResetPasswordFormInput(
      loginType: _loginType,
      identifier: _identifier.text,
    );
    await ref
        .read(requestPasswordResetControllerProvider.notifier)
        .submit(input.toRequest());
  }

  void _onRequested() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Mã xác thực đã được gửi tới '
          '${_loginType == LoginType.email ? 'email' : 'số điện thoại'} '
          'của bạn.',
        ),
      ),
    );
    context.go(Routes.changePassword);
  }

  void _onError(Object error) {
    final message = errorMessageOf(error);
    setState(() {
      switch (resetPasswordErrorFieldOf(error)) {
        case ResetPasswordErrorField.identifier:
          _identifierError = message;
          _identifierFocus.requestFocus();
        case ResetPasswordErrorField.notActivated:
          _formError = message;
          _notActivated = true;
        case ResetPasswordErrorField.form:
          _formError = message;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(requestPasswordResetControllerProvider, (previous, next) {
      if (previous?.isLoading != true) return;
      switch (next) {
        case AsyncError(:final error):
          _onError(error);
        case AsyncData():
          _onRequested();
        default:
      }
    });
    final isLoading = ref
        .watch(requestPasswordResetControllerProvider)
        .isLoading;

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
              enabled: !isLoading,
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
            autofocus: true,
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
            textInputAction: TextInputAction.done,
            enabled: !isLoading,
            onChanged: (_) {
              if (_identifierError != null) {
                setState(() => _identifierError = null);
              }
            },
            onFieldSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: AppSpacing.xl),
          if (_formError case final error?)
            _FormError(message: error, showActivateLink: _notActivated),
          AppButton(
            label: 'RESET',
            onPressed: _submit,
            isLoading: isLoading,
            expand: true,
          ),
        ],
      ),
    );
  }
}

/// Server error under the form; OTP_ACCOUNT_NOT_ACTIVE adds an activate link.
class _FormError extends StatelessWidget {
  const _FormError({required this.message, required this.showActivateLink});

  final String message;
  final bool showActivateLink;

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
          if (showActivateLink)
            AppButton(
              label: 'Kích hoạt',
              variant: AppButtonVariant.text,
              size: AppButtonSize.small,
              onPressed: () => context.go(Routes.activate),
            ),
        ],
      ),
    ),
  );
}
