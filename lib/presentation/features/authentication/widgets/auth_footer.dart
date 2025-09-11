import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:hydrogarden_mobile/app/l10n/l10n.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";

class AuthFooter extends StatelessWidget {
  final bool isLogin;
  final void Function() onRedirect;

  const AuthFooter({
    super.key,
    required this.isLogin,
    required this.onRedirect,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogin
              ? l10n.auth_helper_dont_have_an_account
              : l10n.auth_helper_already_have_an_account,
          style: context.textTheme.bodySmall,
        ),
        TextButton(
          onPressed: onRedirect,
          child: Text(
            isLogin ? l10n.auth_register : l10n.auth_login,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
