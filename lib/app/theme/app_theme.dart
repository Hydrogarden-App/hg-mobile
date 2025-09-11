import "package:flutter/material.dart";
import "package:hydrogarden_mobile/app/theme/color_consts.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";

abstract interface class AppThemeData {
  ThemeData get light => ThemeData.light();
  ThemeData get dark => ThemeData.dark();
}

class AppTheme implements AppThemeData {
  @override
  ThemeData get dark => ThemeData(colorScheme: const ColorScheme.dark());

  @override
  ThemeData get light => ThemeData(
    colorScheme: const ColorScheme.light(
      primary: ColorConsts.pale,
      onPrimary: ColorConsts.dark,
      secondary: ColorConsts.medium,
      shadow: ColorConsts.shadow,
      error: ColorConsts.error,
    ),
    textTheme: _textTheme,
    outlinedButtonTheme: _outlinedButtonTheme,
    inputDecorationTheme: _inputDecorationTheme,
  );

  static const _textTheme = TextTheme(
    titleLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  );

  OutlinedButtonThemeData get _outlinedButtonTheme => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(44, 44),
      backgroundColor: ColorConsts.pale,
      foregroundColor: ColorConsts.medium,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(
        vertical: AppPaddings.small,
        horizontal: AppPaddings.huge,
      ),
      textStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
    ),
  );

  InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: ColorConsts.dark, width: 1),
    ),
    suffixIconColor: ColorConsts.dark,
    labelStyle: TextStyle(
      fontSize: 16,
      color: ColorConsts.dark,
      fontWeight: FontWeight.w500,
    ),
    floatingLabelStyle: TextStyle(fontSize: 14, color: ColorConsts.medium),
    contentPadding: EdgeInsets.symmetric(
      vertical: AppPaddings.small,
      horizontal: AppPaddings.large,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: ColorConsts.medium, width: 2),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: ColorConsts.medium, width: 2),
    ),
    errorStyle: TextStyle(color: ColorConsts.error),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: ColorConsts.dark, width: 1),
    ),
  );
}

extension AppThemeX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
