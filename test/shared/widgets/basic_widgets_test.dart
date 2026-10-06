import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/shared/enums/login_type.dart';
import 'package:ui_ux/shared/widgets/app_avatar.dart';
import 'package:ui_ux/shared/widgets/app_button.dart';
import 'package:ui_ux/shared/widgets/app_text_field.dart';
import 'package:ui_ux/shared/widgets/empty_view.dart';
import 'package:ui_ux/shared/widgets/error_view.dart';
import 'package:ui_ux/shared/widgets/login_type_tabs.dart';
import 'package:ui_ux/shared/widgets/star_rating.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('AppButton', () {
    testWidgets('every variant/size renders and taps', (tester) async {
      var taps = 0;
      await tester.pumpApp(
        Column(
          children: [
            for (final v in AppButtonVariant.values)
              for (final s in AppButtonSize.values)
                AppButton(
                  label: '${v.name} ${s.name}',
                  onPressed: () => taps++,
                  variant: v,
                  size: s,
                  icon: Icons.chat,
                ),
          ],
        ),
      );
      for (final v in AppButtonVariant.values) {
        await tester.tap(find.text('${v.name} regular'));
      }
      expect(taps, AppButtonVariant.values.length);
    });

    testWidgets('loading: spinner and not tappable', (tester) async {
      var taps = 0;
      await tester.pumpApp(
        AppButton(label: 'LOGIN', onPressed: () => taps++, isLoading: true),
      );
      expect(find.text('LOGIN'), findsNothing);
      await tester.tap(find.byType(FilledButton));
      expect(taps, 0);
    });
  });

  group('AppTextField', () {
    testWidgets('validator, server error, obscure toggle', (tester) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpApp(
        Form(
          key: formKey,
          child: Column(
            children: [
              AppTextField(
                label: 'Email',
                validator: (v) =>
                    (v ?? '').isEmpty ? 'Vui lòng nhập email' : null,
              ),
              const AppTextField(label: 'Password', obscure: true),
              const AppTextField(label: 'Bio', errorText: 'Lỗi server'),
            ],
          ),
        ),
      );
      expect(find.text('Lỗi server'), findsOneWidget);

      formKey.currentState!.validate();
      await tester.pump();
      expect(find.text('Vui lòng nhập email'), findsOneWidget);

      await tester.tap(find.byTooltip('Hiện mật khẩu'));
      await tester.pump();
      expect(find.byTooltip('Ẩn mật khẩu'), findsOneWidget);
    });
  });

  group('LoginTypeTabs', () {
    testWidgets('fires only on an actual change', (tester) async {
      final changes = <LoginType>[];
      await tester.pumpApp(
        LoginTypeTabs(value: LoginType.email, onChanged: changes.add),
      );
      await tester.tap(find.text('EMAIL'));
      await tester.tap(find.text('PHONE'));
      expect(changes, [LoginType.phone]);
    });
  });

  group('StarRating', () {
    testWidgets('display rounds label, clamps to 5', (tester) async {
      await tester.pumpApp(
        const Column(children: [StarRating(value: 4.3), StarRating(value: 9)]),
      );
      expect(find.bySemanticsLabel('Đánh giá 4.3 trên 5 sao'), findsOneWidget);
      expect(find.bySemanticsLabel('Đánh giá 5.0 trên 5 sao'), findsOneWidget);
    });

    testWidgets('input reports the tapped star', (tester) async {
      final picked = <int>[];
      await tester.pumpApp(StarRating(value: 0, onChanged: picked.add));
      await tester.tap(find.bySemanticsLabel('4 sao'));
      expect(picked, [4]);
    });
  });

  group('AppAvatar', () {
    testWidgets('initials fallback without url', (tester) async {
      await tester.pumpApp(
        const Column(
          children: [
            AppAvatar(name: 'Nguyễn Văn An'),
            AppAvatar(name: 'agri_shop'),
            AppAvatar(name: '  ', url: ''),
          ],
        ),
      );
      expect(find.text('NA'), findsOneWidget);
      expect(find.text('A'), findsOneWidget);
      expect(find.text('?'), findsOneWidget);
    });
  });

  group('EmptyView / ErrorView', () {
    testWidgets('action and retry callbacks', (tester) async {
      var actions = 0;
      var retries = 0;
      await tester.pumpApp(
        SingleChildScrollView(
          child: Column(
            children: [
              EmptyView(
                message: 'Chưa có đánh giá',
                actionLabel: 'Đánh giá shop',
                onAction: () => actions++,
              ),
              const EmptyView(message: 'Trống', actionLabel: 'hidden'),
              ErrorView(message: 'Lỗi', onRetry: () => retries++),
              ErrorView(
                message: 'Lỗi trang sau',
                onRetry: () => retries++,
                compact: true,
              ),
              const ErrorView(message: 'Không retry'),
            ],
          ),
        ),
      );
      expect(find.text('hidden'), findsNothing);
      expect(find.text('Thử lại'), findsNWidgets(2));
      await tester.tap(find.text('Đánh giá shop'));
      await tester.tap(find.text('Thử lại').first);
      await tester.tap(find.text('Thử lại').last);
      expect([actions, retries], [1, 2]);
    });
  });
}
