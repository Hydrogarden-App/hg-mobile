import "package:clerk_flutter/clerk_flutter.dart";
import "package:flutter/widgets.dart";
import "package:hydrogarden_mobile/app/app.dart";
import "package:hydrogarden_mobile/presentation/authentication/pages/login_page.dart";
import "package:hydrogarden_mobile/presentation/authentication/views/auth_view.dart";

class RegisterPage extends StatelessWidget {
  static const route = "/register";

  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    //return ClerkAuthentication();
    return AuthView(
      isLogin: false,
      onRedirect: () => context.router.push(LoginPage.route),
    );
  }
}
