import "package:flutter/material.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";
import "package:hydrogarden_mobile/app/theme/color_consts.dart";
import "package:hydrogarden_mobile/app/theme/text_consts.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";

extension ThemeDataExtension on AppTheme {
  TextTheme get textTheme => TextTheme(
    titleLarge: TextConsts.title,
    titleMedium: TextConsts.subtitle,
    bodyMedium: TextConsts.normal,
    bodySmall: TextConsts.hint,
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
      textStyle: TextConsts.normal,
    ),
  );

  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
    hintStyle: TextStyle(color: ColorConsts.medium),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: ColorConsts.dark, width: 1),
    ),
    suffixIconColor: ColorConsts.dark,
    labelStyle: TextConsts.normal,
    floatingLabelStyle: TextConsts.hint.copyWith(color: ColorConsts.medium),
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
    titleTextStyle: TextConsts.subtitle,
  );

  PopupMenuThemeData get popupMenuTheme => PopupMenuThemeData(
    elevation: 12,
    color: ColorConsts.pale,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: ColorConsts.shadow),
      borderRadius: BorderRadius.circular(20),
    ),
    shadowColor: ColorConsts.shadow,
  );
}
