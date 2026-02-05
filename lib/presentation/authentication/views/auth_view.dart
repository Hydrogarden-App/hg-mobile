import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";
import "package:hydrogarden_mobile/presentation/authentication/extensions/form_group_extension.dart";
import "package:hydrogarden_mobile/presentation/authentication/widgets/auth_footer.dart";
import "package:hydrogarden_mobile/presentation/authentication/widgets/reactive_password_field.dart";
import "package:reactive_forms/reactive_forms.dart";

import "package:hydrogarden_mobile/app/l10n/l10n.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";
import "package:hydrogarden_mobile/presentation/authentication/bloc/authentication_bloc.dart";

class AuthView extends StatelessWidget {
  AuthView({super.key, required this.isLogin, required this.onRedirect}) {
    _form = isLogin
        ? FormGroupExtension.loginForm(
            emailFieldName: "email",
            passwordFieldName: "password",
          )
        : FormGroupExtension.registerForm(
            emailFieldName: "email",
            passwordFieldName: "password",
            repeatPasswordFieldName: "passwordRepeat",
          );
  }

  static const _passwordLength = 1;

  final bool isLogin;
  final void Function() onRedirect;

  late final FormGroup _form;

  void _submit(BuildContext context) {
    if (_form.valid) {
      final email = _form.control("email").value as String;
      final password = _form.control("password").value as String;

      if (isLogin) {
        context.read<AuthenticationBloc>().add(
          AuthenticationLoginRequested(email, password),
        );
      } else {
        context.read<AuthenticationBloc>().add(
          AuthenticationSignupRequested(email, password),
        );
      }
    } else {
      _form.markAllAsTouched();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      body: Padding(
        padding: const EdgeInsets.all(AppPaddings.gigantic),
        child: ReactiveForm(
          formGroup: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: SizedBox(height: double.infinity)),
              Text(l10n.auth_title, style: context.textTheme.titleLarge),
              const SizedBox(height: AppPaddings.small),
              Text(l10n.auth_subtitle, style: context.textTheme.titleMedium),
              const SizedBox(height: AppPaddings.huge),
              ReactiveTextField<String>(
                formControlName: "email",
                keyboardType: TextInputType.emailAddress,
                cursorColor: context.colorScheme.secondary,
                cursorErrorColor: context.colorScheme.secondary,
                decoration: InputDecoration(labelText: l10n.auth_field_email),
                validationMessages: {
                  ValidationMessage.required: (_) =>
                      l10n.auth_error_email_empty,
                  ValidationMessage.email: (_) => l10n.auth_error_email_invalid,
                },
              ),
              const SizedBox(height: AppPaddings.large),
              ReactivePasswordField(
                formControlName: "password",
                labelText: l10n.auth_field_password,
                cursorColor: context.colorScheme.secondary,
                validationMessages: {
                  ValidationMessage.required: (_) =>
                      l10n.auth_error_password_empty,
                  ValidationMessage.minLength: (_) =>
                      l10n.auth_error_password_too_short(_passwordLength),
                },
              ),
              if (!isLogin) ...[
                const SizedBox(height: AppPaddings.large),
                ReactivePasswordField(
                  formControlName: "passwordRepeat",
                  labelText: l10n.auth_field_password_repeat,
                  cursorColor: context.colorScheme.secondary,
                  validationMessages: {
                    ValidationMessage.required: (_) =>
                        l10n.auth_error_password_empty,
                    ValidationMessage.mustMatch: (_) =>
                        l10n.auth_error_passwords_must_match,
                  },
                ),
              ],
              const SizedBox(height: AppPaddings.enormous),
              OutlinedButton(
                onPressed: () => _submit(context),
                child: Text(isLogin ? l10n.auth_login : l10n.auth_register),
              ),
              const Expanded(child: SizedBox(height: double.infinity)),
              AuthFooter(isLogin: isLogin, onRedirect: onRedirect),
            ],
          ),
        ),
      ),
    );
  }
}
