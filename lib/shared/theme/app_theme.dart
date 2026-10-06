import 'package:flutter/material.dart';
import 'package:ui_ux/shared/theme/app_colors.dart';
import 'package:ui_ux/shared/theme/app_palette.dart';
import 'package:ui_ux/shared/theme/app_spacing.dart';
import 'package:ui_ux/shared/theme/app_typography.dart';

/// Light theme mirroring the web semantic tokens (see [AppColors] mapping).
/// Component defaults here keep widgets free of styling overrides:
/// FilledButton = `.btn-normal`, Card = `.card-normal`.
ThemeData buildAppTheme() {
  const colors = AppColors.light;
  const scheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppPalette.btnMain,
    onPrimary: AppPalette.white,
    // No separate secondary brand color on web: reuse primary.
    secondary: AppPalette.btnMain,
    onSecondary: AppPalette.white,
    error: AppPalette.destructive,
    onError: AppPalette.white,
    surface: AppPalette.bgPage,
    onSurface: AppPalette.textMain,
    onSurfaceVariant: AppPalette.textMain,
    surfaceContainerLowest: AppPalette.bgPage,
    surfaceContainerLow: AppPalette.bgSurface,
    surfaceContainer: AppPalette.bgSurface,
    surfaceContainerHigh: AppPalette.bgSurface,
    surfaceContainerHighest: AppPalette.bgSurface,
    outline: AppPalette.borderSubtle,
    outlineVariant: AppPalette.borderSubtle,
    shadow: AppPalette.black,
    scrim: AppPalette.black,
    surfaceTint: AppPalette.bgPage,
  );
  final text = AppTypography.textTheme(scheme.onSurface);

  const inputBorder = OutlineInputBorder(
    borderRadius: AppRadius.lgAll,
    borderSide: BorderSide(color: AppPalette.borderSubtle),
  );
  const buttonShape = RoundedRectangleBorder(borderRadius: AppRadius.lgAll);
  const buttonPadding = EdgeInsets.symmetric(
    horizontal: AppSpacing.xl,
    vertical: AppSpacing.md,
  );
  const buttonMinSize = Size(AppSpacing.tapTarget, AppSpacing.tapTarget);

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    textTheme: text,
    scaffoldBackgroundColor: scheme.surface,
    extensions: const [colors],
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: text.titleLarge,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        disabledBackgroundColor: scheme.primary.withValues(alpha: 0.4),
        disabledForegroundColor: scheme.onPrimary,
        minimumSize: buttonMinSize,
        padding: buttonPadding,
        shape: buttonShape,
        textStyle: text.labelLarge,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: scheme.primary,
        side: BorderSide(color: scheme.primary),
        minimumSize: buttonMinSize,
        padding: buttonPadding,
        shape: buttonShape,
        textStyle: text.labelLarge,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colors.highlight,
        textStyle: text.labelLarge,
        shape: buttonShape,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      border: inputBorder,
      enabledBorder: inputBorder,
      disabledBorder: inputBorder,
      focusedBorder: inputBorder.copyWith(
        borderSide: BorderSide(color: colors.highlight, width: 1.5),
      ),
      errorBorder: inputBorder.copyWith(
        borderSide: BorderSide(color: scheme.error),
      ),
      focusedErrorBorder: inputBorder.copyWith(
        borderSide: BorderSide(color: scheme.error, width: 1.5),
      ),
      labelStyle: text.bodyMedium,
      floatingLabelStyle: text.bodyMedium?.copyWith(color: colors.highlight),
      hintStyle: text.bodyMedium?.copyWith(
        color: scheme.onSurface.withValues(alpha: 0.5),
      ),
      errorStyle: text.bodySmall?.copyWith(color: scheme.error),
    ),
    cardTheme: const CardThemeData(
      color: AppPalette.bgSurface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.lgAll,
        side: BorderSide(color: AppPalette.borderSubtle),
      ),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: scheme.primary,
      unselectedLabelColor: scheme.onSurface.withValues(alpha: 0.6),
      labelStyle: text.labelLarge,
      unselectedLabelStyle: text.labelLarge,
      indicatorColor: colors.highlight,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: scheme.outline,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: scheme.surface,
      surfaceTintColor: scheme.surface,
      showDragHandle: true,
      dragHandleColor: scheme.outline,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.sheetTop),
    ),
    dividerTheme: DividerThemeData(color: scheme.outline, space: 1),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: scheme.onSurface,
      contentTextStyle: text.bodyMedium?.copyWith(color: scheme.surface),
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: scheme.primary,
    ),
  );
}
