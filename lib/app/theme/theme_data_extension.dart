import "package:flutter/material.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";
import "package:hydrogarden_mobile/app/theme/color_consts.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";

extension ThemeDataExtension on AppTheme {
  TextTheme get textTheme => TextTheme(
    titleLarge: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w600,
      color: ColorConsts.dark,
    ),
    titleMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w300,
      color: ColorConsts.dark,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: ColorConsts.dark,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: ColorConsts.dark,
    ),
  );

  OutlinedButtonThemeData get outlinedButtonTheme => OutlinedButtonThemeData(
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

  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
    hintStyle: TextStyle(color: ColorConsts.medium),
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

  IconThemeData get iconTheme =>
      IconThemeData(color: ColorConsts.dark, size: IconSizeConfig.large);

  SwitchThemeData get switchTheme => SwitchThemeData(
    padding: EdgeInsets.zero,
    thumbColor: WidgetStateProperty.all(ColorConsts.dark),
    trackColor: WidgetStateProperty.resolveWith((states) {
      return states.contains(WidgetState.selected)
          ? ColorConsts.medium
          : ColorConsts.pale;
    }),
    trackOutlineColor: WidgetStateProperty.all(ColorConsts.dark),
  );

  DialogThemeData get dialogTheme => DialogThemeData(
    backgroundColor: ColorConsts.pale,
    titleTextStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w300,
      color: ColorConsts.dark,
    ),
  );
}
