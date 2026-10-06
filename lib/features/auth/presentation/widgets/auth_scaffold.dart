import 'package:flutter/material.dart';
import 'package:ui_ux/features/auth/presentation/widgets/auth_header.dart';
import 'package:ui_ux/shared/extensions/theme_context.dart';
import 'package:ui_ux/shared/theme/app_spacing.dart';

/// Layout of the auth pages (wireframes image.png … image-4.png):
/// [AuthHeader] on top, then a card centered on the page with [title]
/// (section 2), [child] (form, sections 2–4) and [footer] (footer links).
///
/// The whole body scrolls (long register form, keyboard open); tapping
/// outside an input closes the keyboard.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    required this.title,
    required this.child,
    super.key,
    this.footer,
  });

  /// Card width on tablets / landscape; phones use the full width.
  static const _maxCardWidth = 480.0;

  final String title;
  final Widget child;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final footer = this.footer;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        appBar: const AuthHeader(),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.page,
                vertical: AppSpacing.xl,
              ),
              child: ConstrainedBox(
                // Center the card vertically when the content is short.
                constraints: BoxConstraints(
                  minHeight: (constraints.maxHeight - 2 * AppSpacing.xl).clamp(
                    0,
                    double.infinity,
                  ),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: _maxCardWidth),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.xl),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Semantics(
                              header: true,
                              child: Text(
                                title,
                                textAlign: TextAlign.center,
                                style: context.text.headlineSmall,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.lg),
                            child,
                            if (footer != null) ...[
                              const SizedBox(height: AppSpacing.lg),
                              footer,
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
