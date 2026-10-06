import 'package:flutter/material.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/features/location/data/dtos/location_item_dto.dart';
import 'package:ui_ux/features/location/location.dart';
import 'package:ui_ux/features/location/presentation/controllers/wards_provider.dart';

/// Province / ward master data for register tests.
final List<Override> locationOverrides = [
  provincesProvider.overrideWith(
    (ref) async => const [LocationItemDto(codename: 'ha_noi', name: 'Hà Nội')],
  ),
  wardsProvider.overrideWith(
    (ref, code) async => const [
      LocationItemDto(codename: 'phuong_ba_dinh', name: 'Phường Ba Đình'),
    ],
  ),
];

/// Tall view so the whole register form is on screen (no scrolling).
void useTallView(WidgetTester tester) {
  tester.view.physicalSize = const Size(400, 2600);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

/// Fills a valid register form. [distributor] also picks the business type.
Future<void> fillRegisterForm(
  WidgetTester tester, {
  String identifier = 'npp@example.com',
  bool distributor = false,
}) async {
  Future<void> pick(String open, String option) async {
    await tester.tap(find.text(open), warnIfMissed: false);
    await tester.pumpAndSettle();
    await tester.tap(find.text(option));
    await tester.pumpAndSettle();
  }

  final fields = find.byType(EditableText);
  await tester.enterText(fields.at(0), identifier);
  await tester.enterText(fields.at(1), 'secret123');
  await tester.enterText(fields.at(2), 'secret123');
  await tester.pump();
  if (distributor) {
    await tester.tap(find.text('Nhà phân phối'));
    await tester.pumpAndSettle();
    await pick('Chọn loại hình kinh doanh', 'Giống cây trồng');
  }
  await pick('Chọn tỉnh/thành phố', 'Hà Nội');
  await pick('Chọn phường/xã', 'Phường Ba Đình');
  await tester.enterText(
    find.widgetWithText(TextFormField, 'VD: 12 Nguyễn Trãi'),
    '12 Nguyễn Trãi',
  );
  await tester.pump();

  // Map sheet: tap the map (center of the clipped map), then confirm.
  await tester.tap(find.text('Chạm để chọn trên bản đồ'), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.tapAt(tester.getCenter(find.byType(ClipRRect).last));
  // Map taps wait out the double-tap window.
  await tester.pump(const Duration(milliseconds: 500));
  await tester.tap(find.text('Xác nhận'));
  await tester.pumpAndSettle();
}

/// Taps REGISTER (scrolled into view by the tall view).
Future<void> tapRegister(WidgetTester tester) async {
  await tester.tap(find.text('REGISTER'));
  await tester.pump();
}
