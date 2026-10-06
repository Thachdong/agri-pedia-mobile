import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_ux/core/error/error_messages.dart';
import 'package:ui_ux/core/router/routes.dart';
import 'package:ui_ux/features/auth/presentation/auth_validators.dart';
import 'package:ui_ux/features/auth/presentation/controllers/auth_handoff_provider.dart';
import 'package:ui_ux/features/auth/presentation/controllers/login_controller.dart';
import 'package:ui_ux/features/auth/presentation/controllers/login_form_input.dart';
import 'package:ui_ux/shared/enums/login_type.dart';
import 'package:ui_ux/shared/extensions/theme_context.dart';
import 'package:ui_ux/shared/theme/app_spacing.dart';
import 'package:ui_ux/shared/widgets/app_button.dart';
import 'package:ui_ux/shared/widgets/app_text_field.dart';
import 'package:ui_ux/shared/widgets/login_type_tabs.dart';

/// Login form (wireframe image-2.png, sections 2–4 minus footer links):
/// EMAIL | PHONE tabs, identifier, password, LOGIN.
///
/// Init: login handoff (after register / activate / change-password) →
/// prefill loginType + identifier, focus password; none → EMAIL, focus
/// identifier. Switching tab clears the identifier. Errors show under the
/// form; USER_NOT_ACTIVE adds a link to /auth/activate (the controller
/// already saved its handoff). Success navigates through the router guard
/// (`postLoginPath`), not here.
class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _identifier = TextEditingController();
  final _password = TextEditingController();
  final _identifierFocus = FocusNode();
  final _passwordFocus = FocusNode();

  LoginType _loginType = LoginType.email;
  bool _submitted = false;

  /// Server error, cleared on edit or resubmit.
  String? _formError;
  bool _notActivated = false;

  @override
  void initState() {
    super.initState();
    unawaited(_initFromHandoff());
  }

  @override
  void dispose() {
    _identifier.dispose();
    _password.dispose();
    _identifierFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _initFromHandoff() async {
    final handoff = await ref
        .read(loginHandoffProvider.future)
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
    _passwordFocus.requestFocus();
  }

  /// Spec: switching tab sets loginType, swaps validation and clears input.
  void _changeLoginType(LoginType type) {
    if (type == _loginType) return;
    setState(() {
      _loginType = type;
      _identifier.clear();
      _clearServerError();
    });
    _identifierFocus.requestFocus();
  }

  void _clearServerError() {
    _formError = null;
    _notActivated = false;
  }

  void _onEdited(String _) {
    if (_formError != null) setState(_clearServerError);
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _submitted = true;
      _clearServerError();
    });
    if (!_formKey.currentState!.validate()) return;

    final input = LoginFormInput(
      loginType: _loginType,
      identifier: _identifier.text,
      password: _password.text,
    );
    await ref.read(loginControllerProvider.notifier).submit(input.toRequest());
  }

  void _onError(Object error) => setState(() {
    _formError = errorMessageOf(error);
    _notActivated = loginErrorFieldOf(error) == LoginErrorField.notActivated;
  });

  @override
  Widget build(BuildContext context) {
    ref.listen(loginControllerProvider, (previous, next) {
      if (previous?.isLoading != true) return;
      if (next case AsyncError(:final error)) _onError(error);
    });
    final isLoading = ref.watch(loginControllerProvider).isLoading;

    return AutofillGroup(
      child: Form(
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
              validator: AuthValidators.identifier(_loginType),
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
              enabled: !isLoading,
              onChanged: _onEdited,
              onFieldSubmitted: (_) => _passwordFocus.requestFocus(),
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              label: 'Mật khẩu',
              controller: _password,
              focusNode: _passwordFocus,
              obscure: true,
              validator: AuthValidators.loginPassword,
              autofillHints: const [AutofillHints.password],
              textInputAction: TextInputAction.done,
              enabled: !isLoading,
              onChanged: _onEdited,
              onFieldSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: AppSpacing.xl),
            if (_formError case final error?)
              _FormError(message: error, showActivateLink: _notActivated),
            AppButton(
              label: 'LOGIN',
              onPressed: _submit,
              isLoading: isLoading,
              expand: true,
            ),
          ],
        ),
      ),
    );
  }
}

/// Server error under the form; USER_NOT_ACTIVE adds an activate link.
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
