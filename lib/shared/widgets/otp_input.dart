import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_ux/shared/extensions/theme_context.dart';
import 'package:ui_ux/shared/theme/app_spacing.dart';

/// Code input drawn as [length] boxes (activate, change-password).
///
/// One hidden text field holds the whole code, so typing advances box by
/// box, backspace goes back, and paste / SMS autofill fill every box at once
/// (non-digits are dropped). [onCompleted] fires when all boxes are filled —
/// the page then focuses its submit button.
///
/// Pass [controller] to read or clear the code, [focusNode] to focus the
/// first box from the page. Works in a `Form` through [validator].
class OtpInput extends StatefulWidget {
  const OtpInput({
    super.key,
    this.length = 6,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onCompleted,
    this.validator,
    this.errorText,
    this.autofocus = false,
    this.enabled = true,
  });

  final int length;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final FormFieldValidator<String>? validator;

  /// Server error (wrong / expired code); wins over [validator].
  final String? errorText;
  final bool autofocus;
  final bool enabled;

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  TextEditingController? _ownController;
  FocusNode? _ownFocusNode;

  TextEditingController get _controller =>
      widget.controller ?? (_ownController ??= TextEditingController());
  FocusNode get _focusNode =>
      widget.focusNode ?? (_ownFocusNode ??= FocusNode());

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onControllerChanged);
    _focusNode.addListener(_rebuild);
  }

  @override
  void didUpdateWidget(OtpInput old) {
    super.didUpdateWidget(old);
    if (old.controller != widget.controller) {
      (old.controller ?? _ownController)?.removeListener(_onControllerChanged);
      _controller.addListener(_onControllerChanged);
    }
    if (old.focusNode != widget.focusNode) {
      (old.focusNode ?? _ownFocusNode)?.removeListener(_rebuild);
      _focusNode.addListener(_rebuild);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _focusNode.removeListener(_rebuild);
    _ownController?.dispose();
    _ownFocusNode?.dispose();
    super.dispose();
  }

  void _rebuild() => setState(() {});

  // Keeps the caret at the end: boxes are filled strictly left to right.
  void _onControllerChanged() {
    final value = _controller.value;
    final end = TextSelection.collapsed(offset: value.text.length);
    if (value.selection != end) {
      _controller.value = value.copyWith(selection: end);
      return;
    }
    setState(() {});
  }

  void _handleChanged(String code, FormFieldState<String> field) {
    field.didChange(code);
    widget.onChanged?.call(code);
    if (code.length == widget.length) widget.onCompleted?.call(code);
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: _controller.text,
      validator: (_) => widget.validator?.call(_controller.text),
      enabled: widget.enabled,
      builder: (field) {
        final error = widget.errorText ?? field.errorText;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Semantics(
              label: 'Mã xác thực ${widget.length} chữ số',
              textField: true,
              child: Stack(
                children: [
                  _Boxes(
                    length: widget.length,
                    code: _controller.text,
                    focused: _focusNode.hasFocus,
                    hasError: error != null,
                    enabled: widget.enabled,
                  ),
                  Positioned.fill(
                    child: _HiddenField(
                      controller: _controller,
                      focusNode: _focusNode,
                      length: widget.length,
                      autofocus: widget.autofocus,
                      enabled: widget.enabled,
                      onChanged: (code) => _handleChanged(code, field),
                    ),
                  ),
                ],
              ),
            ),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xs),
                child: Text(
                  error,
                  style: context.text.bodySmall?.copyWith(
                    color: context.scheme.error,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// Transparent field over the boxes: receives typing, paste and autofill.
class _HiddenField extends StatelessWidget {
  const _HiddenField({
    required this.controller,
    required this.focusNode,
    required this.length,
    required this.autofocus,
    required this.enabled,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final int length;
  final bool autofocus;
  final bool enabled;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    focusNode: focusNode,
    autofocus: autofocus,
    enabled: enabled,
    onChanged: onChanged,
    keyboardType: TextInputType.number,
    textInputAction: TextInputAction.done,
    autofillHints: const [AutofillHints.oneTimeCode],
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(length),
    ],
    showCursor: false,
    autocorrect: false,
    enableSuggestions: false,
    style: const TextStyle(color: Colors.transparent),
    cursorColor: Colors.transparent,
    decoration: const InputDecoration(
      filled: false,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      contentPadding: EdgeInsets.zero,
      counterText: '',
    ),
  );
}

class _Boxes extends StatelessWidget {
  const _Boxes({
    required this.length,
    required this.code,
    required this.focused,
    required this.hasError,
    required this.enabled,
  });

  final int length;
  final String code;
  final bool focused;
  final bool hasError;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final active = code.length.clamp(0, length - 1);
    return Row(
      children: [
        for (var i = 0; i < length; i++) ...[
          if (i > 0) const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: _Box(
              char: i < code.length ? code[i] : '',
              active: focused && i == active,
              hasError: hasError,
              enabled: enabled,
            ),
          ),
        ],
      ],
    );
  }
}

class _Box extends StatelessWidget {
  const _Box({
    required this.char,
    required this.active,
    required this.hasError,
    required this.enabled,
  });

  final String char;
  final bool active;
  final bool hasError;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;
    final borderColor = hasError
        ? scheme.error
        : active
        ? context.colors.highlight
        : scheme.outline;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      height: AppSpacing.tapTarget,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: enabled ? scheme.surface : scheme.surfaceContainer,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: borderColor, width: active ? 1.5 : 1),
      ),
      child: Text(char, style: context.text.titleLarge),
    );
  }
}
