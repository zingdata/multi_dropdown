import 'package:example/zing_colors.dart';
import 'package:flutter/material.dart';


ThemeData baseTheme() {
  ThemeData baseTheme = ThemeData.light();

  const colorsScheme = ColorScheme(
    primary: ZingColors.blue700,
    primaryContainer: ZingColors.blue50,
    onPrimaryContainer: ZingColors.blue200,
    secondary: ZingColors.neutral600,
    secondaryContainer: ZingColors.neutral50,
    onSecondaryContainer: ZingColors.neutral700,
    tertiary: ZingColors.orange600,
    tertiaryContainer: ZingColors.orange700,
    surface: Colors.white,
    background: Colors.white,
    onBackground: ZingColors.neutral900,
    onSurface: ZingColors.neutral700,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    error: ZingColors.red700,
    errorContainer: ZingColors.red50,
    onErrorContainer: ZingColors.red800,
    brightness: Brightness.light,
    outline: ZingColors.neutral200,
    outlineVariant: ZingColors.neutral500,
    onSurfaceVariant: ZingColors.neutral500,
    surfaceVariant: ZingColors.neutral100,
    onTertiaryContainer: ZingColors.surface1,
  );

  Color getColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return colorsScheme.surfaceVariant;
    }

    return colorsScheme.primary;
  }

  Color getForegroundColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return colorsScheme.onSurfaceVariant;
    }

    return colorsScheme.onPrimary;
  }

  Color getForegroundColorIcon(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return colorsScheme.onSurfaceVariant;
    }

    return colorsScheme.onBackground;
  }

  Color getOverlayColorIcon(Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return colorsScheme.primaryContainer;
    }

    return Colors.transparent;
  }

  final buttonStyle = ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    iconColor: MaterialStateProperty.resolveWith(getForegroundColorIcon),
    backgroundColor: MaterialStateProperty.resolveWith(getColor),
    foregroundColor: MaterialStateProperty.resolveWith(getForegroundColor),
    overlayColor: MaterialStateProperty.all(ZingColors.blue800),
    visualDensity: VisualDensity.standard,
    textStyle: MaterialStatePropertyAll(
      TextStyle(
          color: colorsScheme.onPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          fontFamily: 'NotoSans'),
    ),
    shape: MaterialStateProperty.all(
      const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
    ),
  );

  return ThemeData(
    useMaterial3: true,
    typography: Typography.material2021(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    scaffoldBackgroundColor: colorsScheme.background,
    colorScheme: colorsScheme,
    dividerColor: colorsScheme.outline,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: colorsScheme.primary,
    ),
    hintColor: colorsScheme.secondary,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorsScheme.primary,
      foregroundColor: colorsScheme.onPrimary,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      extendedIconLabelSpacing: 8,
      extendedPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      extendedSizeConstraints: const BoxConstraints(maxHeight: 57, maxWidth: 200),
      iconSize: 18,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: colorsScheme.primaryContainer,
      contentTextStyle: TextStyle(
        color: colorsScheme.onBackground,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
      actionTextColor: colorsScheme.onBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      width: 343,
    ),
    appBarTheme: AppBarTheme(
      scrolledUnderElevation: 1,
      shadowColor: colorsScheme.outline.withOpacity(.5),
      surfaceTintColor: Colors.transparent,
    ),
    dividerTheme: DividerThemeData(
      color: colorsScheme.outline,
      thickness: 1,
      space: 4,
      indent: 0,
      endIndent: 0,
    ),
    iconTheme: IconThemeData(
      color: colorsScheme.onBackground,
      size: 24,
    ),
    filledButtonTheme: FilledButtonThemeData(style: buttonStyle),
    iconButtonTheme: IconButtonThemeData(
      style: buttonStyle.copyWith(
        visualDensity: VisualDensity.standard,
        iconColor: MaterialStateProperty.resolveWith(getForegroundColorIcon),
        iconSize: MaterialStateProperty.all(24),
        backgroundColor: MaterialStateProperty.resolveWith(getOverlayColorIcon),
        foregroundColor: MaterialStateProperty.all(colorsScheme.primaryContainer),
        overlayColor: MaterialStateProperty.all(colorsScheme.primaryContainer),
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
        alignment: Alignment.center,
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: buttonStyle.copyWith(
          foregroundColor: MaterialStateProperty.all(colorsScheme.primary),
          backgroundColor: MaterialStateProperty.all(colorsScheme.onPrimary),
          overlayColor: MaterialStateProperty.all(colorsScheme.primaryContainer),
          side: MaterialStatePropertyAll(BorderSide(color: colorsScheme.primary))),
    ),
    textButtonTheme: TextButtonThemeData(
      style: buttonStyle.copyWith(
        backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
        foregroundColor: MaterialStateProperty.resolveWith(getColor),
        overlayColor: MaterialStateProperty.all(colorsScheme.primaryContainer),
        iconColor: MaterialStatePropertyAll(colorsScheme.primary),
      ),
    ),
    bannerTheme: MaterialBannerThemeData(
      backgroundColor: colorsScheme.primaryContainer,
      dividerColor: colorsScheme.outline,
    ),
    fontFamily: 'NotoSans',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: buttonStyle,
    ),
    textTheme: baseTheme.textTheme.copyWith(
      bodyLarge: TextStyle(
        letterSpacing: 0,
        color: colorsScheme.onBackground,
        fontSize: 16,
        height: 1,
      ),
      bodyMedium: TextStyle(
        letterSpacing: 0,
        color: colorsScheme.onBackground,
        fontSize: 14,
        height: 1,
      ),
      bodySmall: TextStyle(
        letterSpacing: 0,
        color: colorsScheme.onBackground,
        fontSize: 12,
        height: 1,
      ),
      labelLarge: TextStyle(
        letterSpacing: 0,
        color: colorsScheme.onBackground,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1,
      ),
      labelMedium: TextStyle(
        letterSpacing: 0,
        color: colorsScheme.onBackground,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1,
      ),
      labelSmall: TextStyle(
        letterSpacing: 0,
        color: colorsScheme.onBackground,
        fontSize: 10,
        height: 1,
      ),
      titleLarge: TextStyle(
        letterSpacing: 0,
        color: colorsScheme.onBackground,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1,
      ),
      titleMedium: TextStyle(
        letterSpacing: 0,
        color: colorsScheme.onBackground,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1,
      ),
      titleSmall: TextStyle(
        letterSpacing: 0,
        color: colorsScheme.onBackground,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1,
      ),
      displayLarge: TextStyle(
        letterSpacing: 0,
        color: colorsScheme.onBackground,
        fontSize: 64,
        fontWeight: FontWeight.w500,
        height: 1,
      ),
      displayMedium: TextStyle(
        letterSpacing: 0,
        color: colorsScheme.onBackground,
        fontSize: 48,
        fontWeight: FontWeight.w500,
        height: 1,
      ),
      displaySmall: TextStyle(
        letterSpacing: 0,
        color: colorsScheme.onBackground,
        fontSize: 36,
        fontWeight: FontWeight.w500,
        height: 1,
      ),
      headlineLarge: TextStyle(
        letterSpacing: 0,
        color: colorsScheme.onBackground,
        fontSize: 32,
        fontWeight: FontWeight.w500,
        height: 1,
      ),
      headlineMedium: TextStyle(
        letterSpacing: 0,
        color: colorsScheme.onBackground,
        fontSize: 28,
        fontWeight: FontWeight.w500,
        height: 1,
      ),
      headlineSmall: TextStyle(
        letterSpacing: 0,
        color: colorsScheme.onBackground,
        fontSize: 24,
        fontWeight: FontWeight.w500,
        height: 1,
      ),
    ),
    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      elevation: 0,
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: colorsScheme.surface,
      surfaceTintColor: colorsScheme.surface,
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: colorsScheme.surface,
      dayPeriodTextColor: MaterialStateColor.resolveWith(
        (states) => states.contains(MaterialState.selected)
            ? colorsScheme.onPrimary
            : colorsScheme.onBackground,
      ),
      dayPeriodColor: MaterialStateColor.resolveWith(
        (states) =>
            states.contains(MaterialState.selected) ? colorsScheme.primary : colorsScheme.surface,
      ),
      dialBackgroundColor: colorsScheme.surface,
      hourMinuteColor: colorsScheme.surface,
      hourMinuteTextColor: colorsScheme.onBackground,
    ),
  );
}
