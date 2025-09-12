import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hydrogarden_mobile/app/app.dart";
import "package:hydrogarden_mobile/app/l10n/l10n.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";
import "package:hydrogarden_mobile/presentation/authentication/bloc/authentication_bloc.dart";

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: context.colorScheme.primary,
        actions: [
          IconButton(
            onPressed: () => context.router.pop(),
            icon: Icon(Icons.close, size: IconSizeConfig.medium),
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              context.l10n.settings_title,
              style: context.textTheme.titleLarge,
            ),
            SizedBox(height: AppPaddings.large),
            OutlinedButton(
              onPressed: () {
                context.read<AuthenticationBloc>().add(
                  AuthenticationLogoutRequested(),
                );
              },
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(
                  context.colorScheme.error,
                ),
              ),
              child: Text(context.l10n.settings_logout),
            ),
          ],
        ),
      ),
    );
  }
}
