import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_ux/core/error/error_messages.dart';
import 'package:ui_ux/core/router/routes.dart';
import 'package:ui_ux/core/utils/validators.dart';
import 'package:ui_ux/features/auth/presentation/auth_validators.dart';
import 'package:ui_ux/features/auth/presentation/controllers/register_controller.dart';
import 'package:ui_ux/features/auth/presentation/controllers/register_form_input.dart';
import 'package:ui_ux/features/location/location.dart';
import 'package:ui_ux/shared/enums/business_type.dart';
import 'package:ui_ux/shared/enums/login_type.dart';
import 'package:ui_ux/shared/enums/user_role.dart';
import 'package:ui_ux/shared/extensions/theme_context.dart';
import 'package:ui_ux/shared/theme/app_spacing.dart';
import 'package:ui_ux/shared/widgets/app_button.dart';
import 'package:ui_ux/shared/widgets/app_select_field.dart';
import 'package:ui_ux/shared/widgets/app_text_field.dart';
import 'package:ui_ux/shared/widgets/login_type_tabs.dart';

/// Register form (wireframe image.png, sections 2–4 minus footer links):
/// EMAIL | PHONE tabs, identifier, password + confirm, display name, role,
/// business type (DISTRIBUTOR only), bio, address, REGISTER.
///
/// Success: DISTRIBUTOR → /auth/activate (handoff saved by the controller),
/// FARMER → /auth/login. Server errors show under their field
/// ([registerErrorFieldOf]) or under the form.
class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _identifier = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _username = TextEditingController();
  final _bio = TextEditingController();
  final _identifierFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmFocus = FocusNode();
  final _usernameFocus = FocusNode();

  LoginType _loginType = LoginType.email;
  UserRole _role = UserRole.farmer;
  BusinessType? _bussinessType;
  AddressInput _address = const AddressInput();
  bool _submitted = false;

  /// Server errors, cleared when the user edits the matching field.
  String? _identifierError;
  String? _bussinessTypeError;
  String? _addressError;
  String? _formError;

  @override
  void dispose() {
    for (final c in [
      _identifier,
      _password,
      _confirmPassword,
      _username,
      _bio,
    ]) {
      c.dispose();
    }
    for (final f in [
      _identifierFocus,
      _passwordFocus,
      _confirmFocus,
      _usernameFocus,
    ]) {
      f.dispose();
    }
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

  void _clearServerErrors() {
    _identifierError = null;
    _bussinessTypeError = null;
    _addressError = null;
    _formError = null;
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _submitted = true;
      _clearServerErrors();
    });
    if (!_formKey.currentState!.validate()) return;

    final input = RegisterFormInput(
      loginType: _loginType,
      identifier: _identifier.text,
      password: _password.text,
      username: _username.text,
      role: _role,
      bussinessType: _bussinessType,
      bio: _bio.text,
      address: _address,
    );
    await ref
        .read(registerControllerProvider.notifier)
        .submit(input.toRequest());
  }

  void _onSuccess() {
    final messenger = ScaffoldMessenger.of(context);
    if (_role == UserRole.distributor) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Đăng ký thành công. Mã kích hoạt đã được gửi, vui lòng kích hoạt '
            'tài khoản.',
          ),
        ),
      );
      context.go(Routes.activate);
    } else {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Đăng ký thành công. Vui lòng đăng nhập.'),
        ),
      );
      context.go(Routes.login);
    }
  }

  void _onError(Object error) {
    final message = errorMessageOf(error);
    setState(() {
      switch (registerErrorFieldOf(error)) {
        case RegisterErrorField.identifier:
          _identifierError = message;
          _identifierFocus.requestFocus();
        case RegisterErrorField.bussinessType:
          _bussinessTypeError = message;
        case RegisterErrorField.address:
          _addressError = message;
        case RegisterErrorField.form:
          _formError = message;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(registerControllerProvider, (previous, next) {
      if (previous?.isLoading != true) return;
      switch (next) {
        case AsyncError(:final error):
          _onError(error);
        case AsyncData():
          _onSuccess();
        default:
      }
    });
    final isLoading = ref.watch(registerControllerProvider).isLoading;
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
            textInputAction: TextInputAction.next,
            enabled: !isLoading,
            onChanged: (_) {
              if (_identifierError != null) {
                setState(() => _identifierError = null);
              }
            },
            onFieldSubmitted: (_) => _passwordFocus.requestFocus(),
          ),
          gap,
          AppTextField(
            label: 'Mật khẩu',
            hint: '8–128 ký tự',
            controller: _password,
            focusNode: _passwordFocus,
            obscure: true,
            validator: Validators.password,
            autofillHints: const [AutofillHints.newPassword],
            textInputAction: TextInputAction.next,
            enabled: !isLoading,
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
            enabled: !isLoading,
            onFieldSubmitted: (_) => _usernameFocus.requestFocus(),
          ),
          gap,
          AppTextField(
            label: 'Tên hiển thị',
            hint: 'Bỏ trống sẽ dùng email/số điện thoại',
            controller: _username,
            focusNode: _usernameFocus,
            validator: AuthValidators.username,
            maxLength: AuthValidators.usernameMaxLength,
            autofillHints: const [AutofillHints.nickname],
            textInputAction: TextInputAction.done,
            enabled: !isLoading,
          ),
          gap,
          _RoleSelector(
            value: _role,
            enabled: !isLoading,
            onChanged: (role) => setState(() {
              _role = role;
              _bussinessTypeError = null;
            }),
          ),
          if (_role == UserRole.distributor) ...[
            gap,
            AppSelectField<BusinessType>(
              label: 'Loại hình kinh doanh',
              hint: 'Chọn loại hình kinh doanh',
              value: _bussinessType,
              options: BusinessType.values,
              itemLabel: (type) => type.label,
              searchable: false,
              validator: AuthValidators.businessType(_role),
              errorText: _bussinessTypeError,
              enabled: !isLoading,
              onChanged: (type) => setState(() {
                _bussinessType = type;
                _bussinessTypeError = null;
              }),
            ),
          ],
          gap,
          AppTextField(
            label: 'Giới thiệu',
            controller: _bio,
            validator: AuthValidators.bio,
            maxLength: AuthValidators.bioMaxLength,
            maxLines: 3,
            keyboardType: TextInputType.multiline,
            enabled: !isLoading,
          ),
          const SizedBox(height: AppSpacing.lg),
          AddressFields(
            value: _address,
            errorText: _addressError,
            enabled: !isLoading,
            onChanged: (address) => setState(() {
              _address = address;
              _addressError = null;
            }),
          ),
          const SizedBox(height: AppSpacing.xl),
          if (_formError case final error?)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Semantics(
                liveRegion: true,
                child: Text(
                  error,
                  textAlign: TextAlign.center,
                  style: context.text.bodyMedium?.copyWith(
                    color: context.scheme.error,
                  ),
                ),
              ),
            ),
          AppButton(
            label: 'REGISTER',
            onPressed: _submit,
            isLoading: isLoading,
            expand: true,
          ),
        ],
      ),
    );
  }
}

/// "Bạn là": FARMER | DISTRIBUTOR. Not in the wireframe but required by the
/// API (`role`); FARMER is ACTIVE at once, DISTRIBUTOR must activate.
class _RoleSelector extends StatelessWidget {
  const _RoleSelector({
    required this.value,
    required this.onChanged,
    required this.enabled,
  });

  final UserRole value;
  final ValueChanged<UserRole> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.xs),
        child: Text('Bạn là', style: context.text.titleSmall),
      ),
      SegmentedButton<UserRole>(
        segments: [
          for (final role in UserRole.values)
            ButtonSegment(value: role, label: Text(role.label)),
        ],
        selected: {value},
        showSelectedIcon: false,
        onSelectionChanged: enabled ? (s) => onChanged(s.first) : null,
      ),
    ],
  );
}
