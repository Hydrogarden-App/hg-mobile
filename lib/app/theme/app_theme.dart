import "package:flutter/material.dart";
import "package:hydrogarden_mobile/app/theme/color_consts.dart";
import "package:hydrogarden_mobile/app/theme/theme_data_extension.dart";

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
    textTheme: textTheme,
    outlinedButtonTheme: outlinedButtonTheme,
    inputDecorationTheme: inputDecorationTheme,
    iconTheme: iconTheme,
    switchTheme: switchTheme,
    dialogTheme: dialogTheme,
  );
}

extension AppThemeX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
