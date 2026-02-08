import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";

import "package:hydrogarden_mobile/app/l10n/l10n.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";
import "package:hydrogarden_mobile/presentation/authentication/bloc/authentication_bloc.dart";

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      body: Padding(
        padding: const EdgeInsets.all(AppPaddings.gigantic),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(child: SizedBox(height: double.infinity)),
            Text(l10n.auth_title, style: context.textTheme.titleLarge),
            const SizedBox(height: AppPaddings.small),
            Text(l10n.auth_subtitle, style: context.textTheme.titleMedium),
            const SizedBox(height: AppPaddings.huge),
            ElevatedButton(
              onPressed: () {
                context.read<AuthenticationBloc>().add(
                       AuthenticationOAuthRequested(OAuthProvider.apple, context),
                    );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Continue with Apple"),
            ),
            const SizedBox(height: AppPaddings.medium),
            ElevatedButton(
              onPressed: () {
                context.read<AuthenticationBloc>().add(
                       AuthenticationOAuthRequested(OAuthProvider.google, context),
                    );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Continue with Google"),
            ),
            const Expanded(child: SizedBox(height: double.infinity)),
            // Removed AuthFooter as we don't have redirect anymore
            // const AuthFooter(isLogin: true, onRedirect: null),
          ElevatedButton(onPressed: () =>context.read<AuthenticationBloc>().add(AuthenticationCheckRequested()), child: const Text("Check auth status"))
          ],
        ),
      ),
    );
  }
}
