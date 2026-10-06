import 'package:flutter/material.dart';
import 'package:ui_ux/shared/theme/app_colors.dart';

/// Token access for widgets: `context.scheme.primary`,
/// `context.colors.highlight`, `context.text.bodyMedium`.
extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get scheme => Theme.of(this).colorScheme;
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
  TextTheme get text => Theme.of(this).textTheme;
}
