part of "app.dart";

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  initialLocation: LoginPage.route,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: HomePage.route,
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: HomePage());
      },
    ),
    GoRoute(
      path: LoginPage.route,
      pageBuilder: (context, state) {
        print("lgin");
        return NoTransitionPage(child: const LoginPage());
      },
    ),
    GoRoute(
      path: RegisterPage.route,
      pageBuilder: (context, state) {
        print("register");
        return NoTransitionPage(child: const RegisterPage());
      },
    ),
  ],
);

extension ContexRouterX on BuildContext {
  GoRouter get router => GoRouter.of(this);
}
