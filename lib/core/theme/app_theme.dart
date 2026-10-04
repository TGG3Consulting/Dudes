import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_spacing.dart';

abstract class AppTheme {
  static ThemeData get light => _build(isDark: false);
  static ThemeData get dark  => _build(isDark: true);

  static ThemeData _build({required bool isDark}) {
    final cs = _colorScheme(isDark);
    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      scaffoldBackgroundColor: isDark ? AppColors.bgBaseDark : AppColors.bgBaseLight,
      textTheme: _textTheme(isDark),
      appBarTheme: _appBarTheme(isDark, cs),
      elevatedButtonTheme: _elevatedButtonTheme(isDark),
      outlinedButtonTheme: _outlinedButtonTheme(isDark),
      textButtonTheme: _textButtonTheme(isDark),
      inputDecorationTheme: _inputDecorationTheme(isDark),
      bottomNavigationBarTheme: _bottomNavTheme(isDark),
      cardTheme: _cardTheme(isDark),
      dividerTheme: DividerThemeData(
        color: isDark ? AppColors.lineDark : AppColors.lineLight,
        thickness: 1,
        space: 1,
      ),
      focusColor: isDark ? AppColors.focusDark : AppColors.focusLight,
      splashColor: isDark ? AppColors.accentWashDark : AppColors.accentWashLight,
      highlightColor: Colors.transparent,
    );
  }

  static ColorScheme _colorScheme(bool isDark) => ColorScheme(
    brightness: isDark ? Brightness.dark : Brightness.light,
    primary: AppColors.accent,
    onPrimary: AppColors.onAccent,
    primaryContainer: isDark ? AppColors.accentWashDark : AppColors.accentWashLight,
    onPrimaryContainer: isDark ? AppColors.accentInkDark : AppColors.accentInkLight,
    secondary: isDark ? AppColors.accentInkDark : AppColors.accentInkLight,
    onSecondary: isDark ? AppColors.inkDark : AppColors.inkLight,
    secondaryContainer: isDark ? AppColors.bgRaisedDark : AppColors.bgRaisedLight,
    onSecondaryContainer: isDark ? AppColors.inkDark : AppColors.inkLight,
    surface: isDark ? AppColors.bgRaisedDark : AppColors.bgRaisedLight,
    onSurface: isDark ? AppColors.inkDark : AppColors.inkLight,
    surfaceContainerHighest: isDark ? AppColors.bgOverlayDark : AppColors.bgOverlayLight,
    onSurfaceVariant: isDark ? AppColors.inkMutedDark : AppColors.inkMutedLight,
    outline: isDark ? AppColors.lineStrongDark : AppColors.lineStrongLight,
    outlineVariant: isDark ? AppColors.lineDark : AppColors.lineLight,
    error: isDark ? AppColors.errorDark : AppColors.errorLight,
    onError: AppColors.onSignal,
    errorContainer: isDark ? AppColors.errorWashDark : AppColors.errorWashLight,
    onErrorContainer: isDark ? AppColors.errorDark : AppColors.errorLight,
    inverseSurface: isDark ? AppColors.bgInverseDark : AppColors.bgInverseLight,
    onInverseSurface: isDark ? AppColors.inkInverseDark : AppColors.inkInverseLight,
    scrim: isDark ? AppColors.scrimDark : AppColors.scrimLight,
  );

  static TextTheme _textTheme(bool isDark) {
    final ink = isDark ? AppColors.inkDark : AppColors.inkLight;
    final muted = isDark ? AppColors.inkMutedDark : AppColors.inkMutedLight;
    return TextTheme(
      displayLarge:  AppTextStyles.headingXl.copyWith(color: ink),
      displayMedium: AppTextStyles.headingLg.copyWith(color: ink),
      displaySmall:  AppTextStyles.headingMd.copyWith(color: ink),
      headlineLarge:  AppTextStyles.headingLg.copyWith(color: ink),
      headlineMedium: AppTextStyles.headingMd.copyWith(color: ink),
      headlineSmall:  AppTextStyles.bodyLg.copyWith(color: ink),
      titleLarge:  AppTextStyles.bodyLg.copyWith(color: ink),
      titleMedium: AppTextStyles.bodyMd.copyWith(color: ink, fontWeight: FontWeight.w600),
      titleSmall:  AppTextStyles.bodySm.copyWith(color: ink),
      bodyLarge:   AppTextStyles.bodyMd.copyWith(color: ink),
      bodyMedium:  AppTextStyles.bodySm.copyWith(color: ink),
      bodySmall:   AppTextStyles.caption.copyWith(color: muted),
      labelLarge:  AppTextStyles.label.copyWith(color: ink),
      labelMedium: AppTextStyles.caption.copyWith(color: muted),
      labelSmall:  AppTextStyles.caption.copyWith(color: muted, fontSize: 10),
    );
  }

  static AppBarTheme _appBarTheme(bool isDark, ColorScheme cs) => AppBarTheme(
    backgroundColor: isDark ? AppColors.bgBaseDark : AppColors.bgBaseLight,
    foregroundColor: isDark ? AppColors.inkDark : AppColors.inkLight,
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: AppTextStyles.headingMd.copyWith(
      color: isDark ? AppColors.inkDark : AppColors.inkLight,
    ),
    centerTitle: false,
    toolbarHeight: AppSpacing.s14,
  );

  static ElevatedButtonThemeData _elevatedButtonTheme(bool isDark) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.onAccent,
          disabledBackgroundColor: isDark ? AppColors.bgRaisedDark : AppColors.bgRaisedLight,
          disabledForegroundColor: isDark ? AppColors.inkFaintDark : AppColors.inkFaintLight,
          elevation: 0,
          minimumSize: const Size(double.infinity, AppSpacing.s14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: AppTextStyles.label,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
        ),
      );

  static OutlinedButtonThemeData _outlinedButtonTheme(bool isDark) =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: isDark ? AppColors.inkDark : AppColors.inkLight,
          side: BorderSide(
            color: isDark ? AppColors.lineStrongDark : AppColors.lineStrongLight,
          ),
          minimumSize: const Size(double.infinity, AppSpacing.s14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: AppTextStyles.label,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
        ),
      );

  static TextButtonThemeData _textButtonTheme(bool isDark) =>
      TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: isDark ? AppColors.accentInkDark : AppColors.accentInkLight,
          textStyle: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s3,
            vertical: AppSpacing.s2,
          ),
        ),
      );

  static InputDecorationTheme _inputDecorationTheme(bool isDark) =>
      InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.bgRaisedDark : AppColors.bgRaisedLight,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s4,
          vertical: AppSpacing.s3,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(
            color: isDark ? AppColors.lineStrongDark : AppColors.lineStrongLight,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(
            color: isDark ? AppColors.lineStrongDark : AppColors.lineStrongLight,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(
            color: isDark ? AppColors.focusDark : AppColors.focusLight,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.errorFill, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.errorFill, width: 2),
        ),
        hintStyle: AppTextStyles.bodyMd.copyWith(
          color: isDark ? AppColors.inkFaintDark : AppColors.inkFaintLight,
        ),
        errorStyle: AppTextStyles.bodySm.copyWith(
          color: isDark ? AppColors.errorDark : AppColors.errorLight,
        ),
        constraints: const BoxConstraints(minHeight: AppSpacing.s14),
      );

  static BottomNavigationBarThemeData _bottomNavTheme(bool isDark) =>
      BottomNavigationBarThemeData(
        backgroundColor: isDark ? AppColors.bgBaseDark : AppColors.bgBaseLight,
        selectedItemColor: AppColors.accent,
        unselectedItemColor: isDark ? AppColors.inkFaintDark : AppColors.inkFaintLight,
        selectedLabelStyle: AppTextStyles.caption,
        unselectedLabelStyle: AppTextStyles.caption,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      );

  static CardThemeData _cardTheme(bool isDark) => CardThemeData(
    color: isDark ? AppColors.bgRaisedDark : AppColors.bgRaisedLight,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      side: BorderSide(
        color: isDark ? AppColors.lineDark : AppColors.lineLight,
      ),
    ),
    margin: EdgeInsets.zero,
  );
}
