import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_ux/core/device/geo_point.dart';
import 'package:ui_ux/core/device/geolocation_service.dart';
import 'package:ui_ux/shared/extensions/theme_context.dart';
import 'package:ui_ux/shared/theme/app_spacing.dart';
import 'package:ui_ux/shared/widgets/app_button.dart';
import 'package:ui_ux/shared/widgets/app_sheet.dart';
import 'package:ui_ux/shared/widgets/map/map_picker.dart';

/// Opens the map picker. Resolves with the confirmed point, or null when
/// cancelled. [initial] = the point already chosen (editing).
///
/// Not drag-dismissible: a vertical pan on the map must move the map, not
/// close the sheet. Close with Huỷ or the X button.
Future<GeoPoint?> showLocationPickerSheet(
  BuildContext context, {
  GeoPoint? initial,
}) => showAppSheet<GeoPoint>(
  context,
  title: 'Chọn vị trí',
  fullHeight: true,
  isDismissible: false,
  builder: (_) => LocationPickerSheet(initial: initial),
);

/// Content of the map picker sheet: map (tap to place), "Dùng vị trí hiện
/// tại" shortcut, Huỷ / Xác nhận. Pops with the picked [GeoPoint].
class LocationPickerSheet extends ConsumerStatefulWidget {
  const LocationPickerSheet({super.key, this.initial});

  final GeoPoint? initial;

  @override
  ConsumerState<LocationPickerSheet> createState() =>
      _LocationPickerSheetState();
}

class _LocationPickerSheetState extends ConsumerState<LocationPickerSheet> {
  late GeoPoint? _point = widget.initial;
  bool _locating = false;
  bool _locateFailed = false;

  Future<void> _useCurrentLocation() async {
    setState(() {
      _locating = true;
      _locateFailed = false;
    });
    final position = await ref
        .read(geolocationServiceProvider)
        .currentPosition();
    if (!mounted) return;
    setState(() {
      _locating = false;
      _locateFailed = position == null;
      if (position != null) _point = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final point = _point;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Chạm trên bản đồ để chọn vị trí cửa hàng / nhà bạn.',
          style: text.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Expanded(
          child: ClipRRect(
            borderRadius: AppRadius.lgAll,
            child: MapPicker(
              value: point,
              onChanged: (p) => setState(() {
                _point = p;
                _locateFailed = false;
              }),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          point == null
              ? 'Chưa chọn vị trí'
              : 'Đã chọn: ${point.lat.toStringAsFixed(5)}, '
                    '${point.long.toStringAsFixed(5)}',
          style: text.bodySmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppButton(
          label: 'Dùng vị trí hiện tại',
          icon: Icons.my_location,
          variant: AppButtonVariant.outline,
          isLoading: _locating,
          onPressed: _useCurrentLocation,
          expand: true,
        ),
        if (_locateFailed)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: Text(
              'Không lấy được vị trí hiện tại. Hãy bật định vị và cấp quyền '
              'cho ứng dụng, hoặc chạm trên bản đồ để chọn.',
              style: text.bodySmall?.copyWith(color: context.scheme.error),
            ),
          ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: 'Huỷ',
                variant: AppButtonVariant.outline,
                onPressed: () => Navigator.of(context).pop(),
                expand: true,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: AppButton(
                label: 'Xác nhận',
                onPressed: point == null || _locating
                    ? null
                    : () => Navigator.of(context).pop(point),
                expand: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
