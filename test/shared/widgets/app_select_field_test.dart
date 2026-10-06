import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/shared/widgets/app_select_field.dart';

import '../../helpers/pump_app.dart';

const _provinces = ['Hà Nội', 'Hồ Chí Minh', 'Đà Nẵng'];

void main() {
  Future<void> pumpField(
    WidgetTester tester, {
    List<String>? options = _provinces,
    String? loadError,
    VoidCallback? onRetry,
    bool enabled = true,
    bool searchable = true,
    GlobalKey<FormState>? formKey,
    ValueChanged<String>? onPicked,
  }) async {
    String? value;
    await tester.pumpApp(
      StatefulBuilder(
        builder: (context, setState) => Form(
          key: formKey,
          child: AppSelectField<String>(
            label: 'Tỉnh/thành phố',
            hint: 'Chọn tỉnh',
            value: value,
            options: options,
            itemLabel: (o) => o,
            loadError: loadError,
            onRetry: onRetry,
            enabled: enabled,
            searchable: searchable,
            validator: (v) => v == null ? 'Vui lòng chọn' : null,
            onChanged: (v) {
              setState(() => value = v);
              onPicked?.call(v);
            },
          ),
        ),
      ),
    );
  }

  testWidgets('pick from sheet with accent-insensitive search', (tester) async {
    String? picked;
    await pumpField(tester, onPicked: (v) => picked = v);

    await tester.tap(find.text('Chọn tỉnh'), warnIfMissed: false);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, 'da nang');
    await tester.pump();

    expect(find.text('Hà Nội'), findsNothing);
    await tester.tap(find.text('Đà Nẵng'));
    await tester.pumpAndSettle();

    expect(picked, 'Đà Nẵng');
    expect(find.text('Đà Nẵng'), findsOneWidget);
  });

  testWidgets('search without match shows empty state', (tester) async {
    await pumpField(tester);

    await tester.tap(find.text('Chọn tỉnh'), warnIfMissed: false);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, 'xyz');
    await tester.pump();

    expect(find.text('Không tìm thấy kết quả'), findsOneWidget);
  });

  testWidgets('not searchable → no search box', (tester) async {
    await pumpField(tester, searchable: false);

    await tester.tap(find.text('Chọn tỉnh'), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(find.text('Tìm kiếm'), findsNothing);
    expect(find.text('Hồ Chí Minh'), findsOneWidget);
  });

  testWidgets('validator runs on Form.validate, clears after pick', (
    tester,
  ) async {
    final formKey = GlobalKey<FormState>();
    await pumpField(tester, formKey: formKey);

    expect(formKey.currentState!.validate(), isFalse);
    await tester.pump();
    expect(find.text('Vui lòng chọn'), findsOneWidget);

    await tester.tap(find.text('Chọn tỉnh'), warnIfMissed: false);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Hà Nội'));
    await tester.pumpAndSettle();

    expect(formKey.currentState!.validate(), isTrue);
  });

  testWidgets('loading (options null) → spinner, not tappable', (tester) async {
    await pumpField(tester, options: null);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.tap(find.text('Chọn tỉnh'), warnIfMissed: false);
    // Spinner never settles: pump a fixed time instead of pumpAndSettle.
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(BottomSheet), findsNothing);
  });

  testWidgets('disabled with null options → no spinner, no sheet', (
    tester,
  ) async {
    await pumpField(tester, options: null, enabled: false);

    expect(find.byType(CircularProgressIndicator), findsNothing);
    await tester.tap(find.text('Chọn tỉnh'), warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(find.byType(BottomSheet), findsNothing);
  });

  testWidgets('load error shown; tap retries instead of opening', (
    tester,
  ) async {
    var retries = 0;
    await pumpField(
      tester,
      options: null,
      loadError: 'Không có kết nối mạng.',
      onRetry: () => retries++,
    );

    expect(find.text('Không có kết nối mạng.'), findsOneWidget);
    await tester.tap(find.text('Chọn tỉnh'), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(retries, 1);
    expect(find.byType(BottomSheet), findsNothing);
  });

  testWidgets('field disposed while the sheet is open → no crash', (
    tester,
  ) async {
    var showField = true;
    late StateSetter setOuter;
    String? picked;
    await tester.pumpApp(
      StatefulBuilder(
        builder: (context, setState) {
          setOuter = setState;
          return showField
              ? AppSelectField<String>(
                  label: 'Tỉnh/thành phố',
                  hint: 'Chọn tỉnh',
                  value: null,
                  options: _provinces,
                  itemLabel: (o) => o,
                  onChanged: (v) => picked = v,
                )
              : const SizedBox.shrink();
        },
      ),
    );

    await tester.tap(find.text('Chọn tỉnh'), warnIfMissed: false);
    await tester.pumpAndSettle();
    setOuter(() => showField = false);
    await tester.pump();
    await tester.tap(find.text('Hà Nội'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(picked, isNull);
  });
}
