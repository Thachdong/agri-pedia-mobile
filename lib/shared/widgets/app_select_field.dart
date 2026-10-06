import 'package:flutter/material.dart';
import 'package:ui_ux/shared/extensions/theme_context.dart';
import 'package:ui_ux/shared/theme/app_spacing.dart';
import 'package:ui_ux/shared/widgets/app_sheet.dart';
import 'package:ui_ux/shared/widgets/empty_view.dart';

/// Pick-one form field with the label above the box (same look as
/// `AppTextField`). Tapping opens a bottom sheet listing [options], with a
/// search box when [searchable] (accent-insensitive: "ha noi" finds "Hà Nội").
///
/// Works inside a `Form`: [validator] runs on `FormState.validate()` against
/// the current [value]. [errorText] (server error) wins over the validator.
///
/// [options] null = still loading (spinner, not tappable). [loadError] shows
/// under the box; tapping then calls [onRetry] instead of opening the sheet.
class AppSelectField<T> extends StatelessWidget {
  const AppSelectField({
    required this.label,
    required this.value,
    required this.options,
    required this.itemLabel,
    required this.onChanged,
    super.key,
    this.hint,
    this.sheetTitle,
    this.validator,
    this.errorText,
    this.loadError,
    this.onRetry,
    this.searchable = true,
    this.enabled = true,
  });

  final String label;
  final T? value;
  final List<T>? options;
  final String Function(T option) itemLabel;
  final ValueChanged<T> onChanged;

  /// Shown while nothing is selected, e.g. "Chọn tỉnh/thành phố".
  final String? hint;

  /// Defaults to [label].
  final String? sheetTitle;
  final String? Function(T? value)? validator;
  final String? errorText;
  final String? loadError;
  final VoidCallback? onRetry;
  final bool searchable;

  /// False e.g. for ward until a province is chosen.
  final bool enabled;

  bool get _isLoading => options == null && loadError == null;

  Future<void> _open(BuildContext context, FormFieldState<T> field) async {
    if (loadError != null) {
      onRetry?.call();
      return;
    }
    final list = options;
    if (list == null) return;
    final picked = await showAppSheet<_Picked<T>>(
      context,
      title: sheetTitle ?? label,
      fullHeight: searchable,
      builder: (_) => _OptionList<T>(
        options: list,
        selected: value,
        itemLabel: itemLabel,
        searchable: searchable,
      ),
    );
    if (picked == null) return;
    field.didChange(picked.value);
    if (picked.value != value) onChanged(picked.value);
  }

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final current = value;
    return FormField<T>(
      initialValue: current,
      validator: validator == null ? null : (_) => validator!(value),
      builder: (field) {
        final interactive = enabled && !_isLoading;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Text(label, style: text.titleSmall),
            ),
            Semantics(
              button: true,
              enabled: interactive,
              label: label,
              value: current == null ? null : itemLabel(current),
              excludeSemantics: true,
              child: InkWell(
                onTap: interactive ? () => _open(context, field) : null,
                borderRadius: AppRadius.mdAll,
                child: InputDecorator(
                  isEmpty: current == null,
                  decoration: InputDecoration(
                    enabled: enabled,
                    hintText: hint,
                    errorText: errorText ?? loadError ?? field.errorText,
                    errorMaxLines: 3,
                    suffixIcon: _Suffix(
                      isLoading: _isLoading,
                      hasLoadError: loadError != null,
                    ),
                  ),
                  child: Text(
                    current == null ? '' : itemLabel(current),
                    style: text.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Wraps the sheet result so "picked" and "dismissed" differ even for a
/// nullable [T].
class _Picked<T> {
  const _Picked(this.value);

  final T value;
}

class _Suffix extends StatelessWidget {
  const _Suffix({required this.isLoading, required this.hasLoadError});

  static const _spinnerSize = AppSpacing.lg;

  final bool isLoading;
  final bool hasLoadError;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: SizedBox.square(
          dimension: _spinnerSize,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }
    return Icon(hasLoadError ? Icons.refresh : Icons.expand_more);
  }
}

class _OptionList<T> extends StatefulWidget {
  const _OptionList({
    required this.options,
    required this.selected,
    required this.itemLabel,
    required this.searchable,
  });

  final List<T> options;
  final T? selected;
  final String Function(T option) itemLabel;
  final bool searchable;

  @override
  State<_OptionList<T>> createState() => _OptionListState<T>();
}

class _OptionListState<T> extends State<_OptionList<T>> {
  final _search = TextEditingController();
  late List<T> _visible = widget.options;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _filter(String query) {
    final q = _fold(query.trim());
    setState(() {
      _visible = q.isEmpty
          ? widget.options
          : widget.options
                .where((o) => _fold(widget.itemLabel(o)).contains(q))
                .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final list = _visible.isEmpty
        ? const EmptyView(
            message: 'Không tìm thấy kết quả',
            icon: Icons.search_off,
          )
        : ListView.builder(
            shrinkWrap: !widget.searchable,
            physics: widget.searchable
                ? null
                : const NeverScrollableScrollPhysics(),
            itemCount: _visible.length,
            itemBuilder: (context, i) {
              final option = _visible[i];
              final isSelected = option == widget.selected;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(widget.itemLabel(option)),
                selected: isSelected,
                trailing: isSelected ? const Icon(Icons.check) : null,
                onTap: () => Navigator.of(context).pop(_Picked<T>(option)),
              );
            },
          );

    if (!widget.searchable) return list;
    return Column(
      children: [
        TextField(
          controller: _search,
          onChanged: _filter,
          textInputAction: TextInputAction.search,
          decoration: const InputDecoration(
            hintText: 'Tìm kiếm',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Expanded(child: list),
      ],
    );
  }
}

/// Lowercase without Vietnamese diacritics, for accent-insensitive search.
String _fold(String input) {
  final buffer = StringBuffer();
  for (final rune in input.toLowerCase().runes) {
    final char = String.fromCharCode(rune);
    buffer.write(_unaccent[char] ?? char);
  }
  return buffer.toString();
}

final Map<String, String> _unaccent = {
  for (final entry in const {
    'a': 'àáạảãâầấậẩẫăằắặẳẵ',
    'e': 'èéẹẻẽêềếệểễ',
    'i': 'ìíịỉĩ',
    'o': 'òóọỏõôồốộổỗơờớợởỡ',
    'u': 'ùúụủũưừứựửữ',
    'y': 'ỳýỵỷỹ',
    'd': 'đ',
  }.entries)
    for (final accented in entry.value.split('')) accented: entry.key,
};
