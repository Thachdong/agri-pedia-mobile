import 'package:flutter/material.dart';

/// Text roles. Font sizes live only here; widgets pick a role from
/// `context.text` and at most change its weight or color.
///
/// | Role          | Use                                  |
/// |---------------|--------------------------------------|
/// | headlineSmall | page title ("Reset Password")        |
/// | titleLarge    | section / sheet title                |
/// | titleMedium   | card title, username                 |
/// | titleSmall    | list item title, table header        |
/// | bodyLarge     | input text                           |
/// | bodyMedium    | default body                         |
/// | bodySmall     | secondary info, timestamps, helper   |
/// | labelLarge    | buttons, tabs                        |
/// | labelMedium   | chips, badges                        |
/// | labelSmall    | tiny captions, counters              |
///
/// Font: platform default (SF Pro / Roboto). The web uses Geist; add the
/// font asset here if the design requires it.
abstract final class AppTypography {
  static TextTheme textTheme(Color color) => TextTheme(
    displaySmall: _style(36, 44, FontWeight.w600, color),
    headlineMedium: _style(28, 36, FontWeight.w600, color),
    headlineSmall: _style(24, 32, FontWeight.w600, color),
    titleLarge: _style(20, 28, FontWeight.w600, color),
    titleMedium: _style(16, 24, FontWeight.w600, color),
    titleSmall: _style(14, 20, FontWeight.w600, color),
    bodyLarge: _style(16, 24, FontWeight.w400, color),
    bodyMedium: _style(14, 20, FontWeight.w400, color),
    bodySmall: _style(12, 16, FontWeight.w400, color),
    labelLarge: _style(14, 20, FontWeight.w600, color),
    labelMedium: _style(12, 16, FontWeight.w500, color),
    labelSmall: _style(11, 16, FontWeight.w500, color),
  );

  static TextStyle _style(
    double size,
    double lineHeight,
    FontWeight weight,
    Color color,
  ) => TextStyle(
    fontSize: size,
    height: lineHeight / size,
    fontWeight: weight,
    color: color,
    letterSpacing: 0,
  );
}
