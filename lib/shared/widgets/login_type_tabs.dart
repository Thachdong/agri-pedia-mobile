import 'package:flutter/material.dart';
import 'package:ui_ux/shared/enums/login_type.dart';
import 'package:ui_ux/shared/extensions/theme_context.dart';
import 'package:ui_ux/shared/theme/app_spacing.dart';

/// EMAIL | PHONE switch of the auth forms (wireframe section 2).
///
/// Controlled: the page keeps the [value]. Per spec, on change the page sets
/// loginType, swaps the identifier validator/keyboard and clears the input.
class LoginTypeTabs extends StatelessWidget {
  const LoginTypeTabs({
    required this.value,
    required this.onChanged,
    super.key,
    this.enabled = true,
  });

  final LoginType value;
  final ValueChanged<LoginType> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;
    return Center(
      child: SegmentedButton<LoginType>(
        segments: [
          for (final type in LoginType.values)
            ButtonSegment(value: type, label: Text(type.tabLabel)),
        ],
        selected: {value},
        showSelectedIcon: false,
        onSelectionChanged: enabled
            ? (selection) {
                final next = selection.first;
                if (next != value) onChanged(next);
              }
            : null,
        style: SegmentedButton.styleFrom(
          backgroundColor: scheme.surface,
          foregroundColor: scheme.onSurface,
          selectedBackgroundColor: scheme.primary,
          selectedForegroundColor: scheme.onPrimary,
          side: BorderSide(color: scheme.outline),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.lgAll),
          textStyle: context.text.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        ),
      ),
    );
  }
}
