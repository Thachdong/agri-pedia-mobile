import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/features/location/data/dtos/location_item_dto.dart';
import 'package:ui_ux/features/location/location.dart';
import 'package:ui_ux/features/location/presentation/controllers/wards_provider.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  late AddressInput value;

  Future<void> pumpFields(
    WidgetTester tester, {
    Future<List<LocationItemDto>> Function()? provinces,
  }) async {
    value = const AddressInput();
    await tester.pumpApp(
      StatefulBuilder(
        builder: (context, setState) => SingleChildScrollView(
          child: AddressFields(
            value: value,
            onChanged: (v) => setState(() => value = v),
          ),
        ),
      ),
      overrides: [
        provincesProvider.overrideWith(
          (ref) =>
              provinces?.call() ??
              Future.value(const [
                LocationItemDto(codename: 'ha_noi', name: 'Hà Nội'),
                LocationItemDto(codename: 'da_nang', name: 'Đà Nẵng'),
              ]),
        ),
        wardsProvider.overrideWith(
          (ref, code) async => [
            LocationItemDto(codename: '${code}_w1', name: 'Phường 1 $code'),
          ],
        ),
      ],
    );
    await tester.pumpAndSettle();
  }

  Future<void> pick(WidgetTester tester, String open, String option) async {
    await tester.tap(find.text(open), warnIfMissed: false);
    await tester.pumpAndSettle();
    await tester.tap(find.text(option));
    await tester.pumpAndSettle();
  }

  testWidgets('ward disabled until a province is chosen', (tester) async {
    await pumpFields(tester);

    expect(find.text('Chọn tỉnh/thành phố trước'), findsOneWidget);
    await tester.tap(
      find.text('Chọn tỉnh/thành phố trước'),
      warnIfMissed: false,
    );
    await tester.pumpAndSettle();
    expect(find.byType(BottomSheet), findsNothing);
  });

  testWidgets('province → wards of that province; change resets ward', (
    tester,
  ) async {
    await pumpFields(tester);

    await pick(tester, 'Chọn tỉnh/thành phố', 'Hà Nội');
    await pick(tester, 'Chọn phường/xã', 'Phường 1 ha_noi');
    expect(value.provinceCode, 'ha_noi');
    expect(value.wardCode, 'ha_noi_w1');

    await pick(tester, 'Hà Nội', 'Đà Nẵng');

    expect(value.provinceCode, 'da_nang');
    expect(value.wardCode, isNull);
    expect(find.text('Chọn phường/xã'), findsOneWidget);
  });

  testWidgets('two edits before a rebuild keep both (regression)', (
    tester,
  ) async {
    await pumpFields(tester);
    await pick(tester, 'Chọn tỉnh/thành phố', 'Hà Nội');

    // enterText without pump: the parent has not rebuilt yet.
    await tester.enterText(
      find.widgetWithText(TextFormField, 'VD: 12 Nguyễn Trãi'),
      '12 Nguyễn Trãi',
    );
    await pick(tester, 'Chọn phường/xã', 'Phường 1 ha_noi');

    expect(value.houseNumber, '12 Nguyễn Trãi');
    expect(value.wardCode, 'ha_noi_w1');
  });

  testWidgets('provinces load error → message + retry', (tester) async {
    var calls = 0;
    await pumpFields(
      tester,
      provinces: () async {
        calls++;
        if (calls == 1) {
          throw const ApiException(
            code: ApiException.networkError,
            message: 'offline',
          );
        }
        return const [LocationItemDto(codename: 'ha_noi', name: 'Hà Nội')];
      },
    );

    expect(
      find.text('Không có kết nối mạng. Vui lòng kiểm tra và thử lại.'),
      findsOneWidget,
    );
    await tester.tap(find.text('Chọn tỉnh/thành phố'), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(calls, 2);
    await pick(tester, 'Chọn tỉnh/thành phố', 'Hà Nội');
    expect(value.provinceCode, 'ha_noi');
  });
}
