import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_ux/core/error/error_messages.dart';
import 'package:ui_ux/features/location/domain/models/address_input.dart';
import 'package:ui_ux/features/location/presentation/address_validators.dart';
import 'package:ui_ux/features/location/presentation/controllers/provinces_provider.dart';
import 'package:ui_ux/features/location/presentation/controllers/wards_provider.dart';
import 'package:ui_ux/features/location/presentation/widgets/location_picker_field.dart';
import 'package:ui_ux/shared/extensions/theme_context.dart';
import 'package:ui_ux/shared/theme/app_spacing.dart';
import 'package:ui_ux/shared/widgets/app_select_field.dart';
import 'package:ui_ux/shared/widgets/app_text_field.dart';

/// Address section of a form (register, later profile address):
/// province → ward (ward list follows the province and resets when it
/// changes), house number / street, and the map point.
///
/// Controlled: [value] in, every edit out through [onChanged]. Validators
/// run with the parent `Form`. [errorText] = server address error
/// (USER_LOCATION_INVALID, USER_INVALID_COORDINATES), shown under the section.
class AddressFields extends ConsumerStatefulWidget {
  const AddressFields({
    required this.value,
    required this.onChanged,
    super.key,
    this.errorText,
    this.enabled = true,
  });

  final AddressInput value;
  final ValueChanged<AddressInput> onChanged;
  final String? errorText;
  final bool enabled;

  @override
  ConsumerState<AddressFields> createState() => _AddressFieldsState();
}

class _AddressFieldsState extends ConsumerState<AddressFields> {
  late final _houseNumber = TextEditingController(
    text: widget.value.houseNumber,
  );

  @override
  void didUpdateWidget(AddressFields old) {
    super.didUpdateWidget(old);
    // Reset from outside (e.g. form cleared): keep the text box in sync.
    if (widget.value.houseNumber != _houseNumber.text) {
      _houseNumber.text = widget.value.houseNumber;
    }
  }

  @override
  void dispose() {
    _houseNumber.dispose();
    super.dispose();
  }

  void _emit(AddressInput next) => widget.onChanged(next);

  @override
  Widget build(BuildContext context) {
    final value = widget.value;
    final provinceCode = value.provinceCode;
    final provinces = ref.watch(provincesProvider);
    final wards = provinceCode == null
        ? null
        : ref.watch(wardsProvider(provinceCode));
    final provinceOptions = provinces.value;
    final wardOptions = wards?.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSelectField(
          label: 'Tỉnh/thành phố',
          hint: 'Chọn tỉnh/thành phố',
          value: provinceOptions
              ?.where((p) => p.codename == provinceCode)
              .firstOrNull,
          options: provinceOptions,
          itemLabel: (p) => p.name,
          loadError: provinces.hasError && provinceOptions == null
              ? errorMessageOf(provinces.error)
              : null,
          onRetry: () => ref.invalidate(provincesProvider),
          validator: (_) => AddressValidators.province(provinceCode),
          enabled: widget.enabled,
          onChanged: (p) =>
              _emit(value.copyWith(provinceCode: p.codename, wardCode: null)),
        ),
        const SizedBox(height: AppSpacing.md),
        AppSelectField(
          // New province → new field state (no stale validation message).
          key: ValueKey(provinceCode),
          label: 'Phường/xã',
          hint: provinceCode == null
              ? 'Chọn tỉnh/thành phố trước'
              : 'Chọn phường/xã',
          value: wardOptions
              ?.where((w) => w.codename == value.wardCode)
              .firstOrNull,
          options: wardOptions,
          itemLabel: (w) => w.name,
          loadError: wards != null && wards.hasError && wardOptions == null
              ? errorMessageOf(wards.error)
              : null,
          onRetry: provinceCode == null
              ? null
              : () => ref.invalidate(wardsProvider(provinceCode)),
          validator: (_) => AddressValidators.ward(value.wardCode),
          enabled: widget.enabled && provinceCode != null,
          onChanged: (w) => _emit(value.copyWith(wardCode: w.codename)),
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          label: 'Số nhà, tên đường',
          hint: 'VD: 12 Nguyễn Trãi',
          controller: _houseNumber,
          validator: AddressValidators.houseNumber,
          textInputAction: TextInputAction.done,
          maxLength: AddressValidators.houseNumberMaxLength,
          enabled: widget.enabled,
          onChanged: (text) => _emit(value.copyWith(houseNumber: text)),
        ),
        const SizedBox(height: AppSpacing.md),
        LocationPickerField(
          value: value.point,
          validator: AddressValidators.point,
          enabled: widget.enabled,
          onChanged: (p) => _emit(value.copyWith(point: p)),
        ),
        if (widget.errorText case final error?)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: Text(
              error,
              style: context.text.bodySmall?.copyWith(
                color: context.scheme.error,
              ),
            ),
          ),
      ],
    );
  }
}
