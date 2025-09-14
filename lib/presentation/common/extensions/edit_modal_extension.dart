import "package:flutter/material.dart";
import "package:hydrogarden_mobile/app/app.dart";
import "package:hydrogarden_mobile/app/l10n/l10n.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";

extension CustomModalExtension on BuildContext {
  Future<void> showEditableTextDialog({
    required String placeholder,
    required String titleText,
    required void Function(String newValue) onSubmitted,
  }) async {
    final controller = TextEditingController(text: placeholder);

    await showDialog(
      context: this,
      builder: (context) {
        return AlertDialog(
          backgroundColor: context.colorScheme.primary,
          title: Text(titleText),
          content: TextField(
            cursorColor: context.colorScheme.secondary,
            controller: controller,
            decoration: InputDecoration(
              hintText: placeholder,
              border: const OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => context.router.pop(),
              child: Text(
                context.l10n.common_cancel,
                style: context.textTheme.bodyMedium,
              ),
            ),
            OutlinedButton(
              onPressed: () {
                context.router.pop();
                onSubmitted(controller.text.trim());
              },
              child: Text(
                context.l10n.common_save,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.secondary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
