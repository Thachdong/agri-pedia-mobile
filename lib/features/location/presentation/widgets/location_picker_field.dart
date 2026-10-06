import 'package:flutter/material.dart';
import 'package:ui_ux/core/device/geo_point.dart';
import 'package:ui_ux/features/location/presentation/sheets/location_picker_sheet.dart';
import 'package:ui_ux/shared/extensions/theme_context.dart';
import 'package:ui_ux/shared/theme/app_spacing.dart';

/// Form field for the address coordinates (lat/long): shows the picked
/// point, tap opens the map picker sheet. Same look as `AppSelectField`.
///
/// Works inside a `Form`: [validator] runs against the current [value];
/// [errorText] (server error) wins over it.
class LocationPickerField extends StatelessWidget {
  const LocationPickerField({
    required this.value,
    required this.onChanged,
    super.key,
    this.label = 'Vị trí trên bản đồ',
    this.validator,
    this.errorText,
    this.enabled = true,
  });

  final GeoPoint? value;
  final ValueChanged<GeoPoint> onChanged;
  final String label;
  final String? Function(GeoPoint? value)? validator;
  final String? errorText;
  final bool enabled;

  static String _format(GeoPoint p) =>
      '${p.lat.toStringAsFixed(5)}, ${p.long.toStringAsFixed(5)}';

  Future<void> _open(
    BuildContext context,
    FormFieldState<GeoPoint> field,
  ) async {
    final picked = await showLocationPickerSheet(context, initial: value);
    // Field gone while the sheet was open (e.g. route changed).
    if (picked == null || !field.mounted) return;
    field.didChange(picked);
    if (picked != value) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final current = value;
    return FormField<GeoPoint>(
      initialValue: current,
      validator: validator == null ? null : (_) => validator!(value),
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Text(label, style: text.titleSmall),
          ),
          Semantics(
            button: true,
            enabled: enabled,
            label: label,
            value: current == null ? 'Chưa chọn' : _format(current),
            excludeSemantics: true,
            child: InkWell(
              onTap: enabled ? () => _open(context, field) : null,
              borderRadius: AppRadius.mdAll,
              child: InputDecorator(
                isEmpty: current == null,
                decoration: InputDecoration(
                  enabled: enabled,
                  hintText: 'Chạm để chọn trên bản đồ',
                  errorText: errorText ?? field.errorText,
                  errorMaxLines: 3,
                  prefixIcon: const Icon(Icons.map_outlined),
                  suffixIcon: const Icon(Icons.chevron_right),
                ),
                child: Text(
                  current == null ? '' : _format(current),
                  style: text.bodyLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
