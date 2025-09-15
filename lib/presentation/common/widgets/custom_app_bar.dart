import "package:flutter/material.dart";
import "package:hydrogarden_mobile/app/app.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";
import "package:hydrogarden_mobile/presentation/settings/settings_page.dart";

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onSettings;
  final bool hasBackButton;

  const CustomAppBar({super.key, this.onSettings, this.hasBackButton = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: hasBackButton
          ? IconButton(
              icon: Icon(Icons.chevron_left, size: IconSizeConfig.medium),
              onPressed: () => context.router.pop(),
            )
          : null,
      actions: [
        IconButton(
          onPressed: (onSettings != null)
              ? onSettings
              : () => context.router.push(SettingsPage.route),
          icon: Icon(Icons.settings, size: IconSizeConfig.medium),
        ),
      ],
      backgroundColor: context.colorScheme.primary,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
