import "package:flutter/widgets.dart";
import "package:hydrogarden_mobile/app/app.dart";
import "package:hydrogarden_mobile/presentation/features/authentication/pages/register_page.dart";
import "package:hydrogarden_mobile/presentation/features/authentication/views/auth_view.dart";

class LoginPage extends StatelessWidget {
  static const route = "/login";

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthView(
      isLogin: true,
      onRedirect: () => context.router.push(RegisterPage.route),
    );
  }
}
