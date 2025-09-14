import "package:flutter/material.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";

import "../../../app/theme/app_theme.dart";

extension CustomSnackBar on BuildContext {
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: textTheme.bodySmall?.copyWith(color: colorScheme.primary),
        ),
        padding: const EdgeInsets.all(AppPaddings.medium),
        backgroundColor: colorScheme.error,
      ),
    );
  }

  void showInfoSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: textTheme.bodySmall),
        padding: const EdgeInsets.all(AppPaddings.medium),
        backgroundColor: colorScheme.secondary,
      ),
    );
  }
}
