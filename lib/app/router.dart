part of "app.dart";

class AppRouter {
  final AuthenticationBloc _authBloc;

  AppRouter(this._authBloc);

  final _rootNavigatorKey = GlobalKey<NavigatorState>();

  late final GoRouter router = GoRouter(
    initialLocation: HomePage.route,
    navigatorKey: _rootNavigatorKey,
    refreshListenable: StreamToListenable(_authBloc.stream),
    routes: [
      GoRoute(
        path: HomePage.route,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: HomePage()),
      ),
      GoRoute(
        path: LoginPage.route,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: LoginPage()),
      ),
      GoRoute(
        path: RegisterPage.route,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: RegisterPage()),
      ),
      GoRoute(
        path: DeviceInfoPage.route,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: DeviceInfoPage()),
      ),
      GoRoute(
        path: CircuitListPage.route,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: CircuitListPage()),
      ),
      GoRoute(
        path: LogsPage.route,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: LogsPage()),
      ),
      GoRoute(
        path: SettingsPage.route,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const SettingsPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.0, -0.3);
                  const end = Offset.zero;
                  final tween = Tween(
                    begin: begin,
                    end: end,
                  ).chain(CurveTween(curve: Curves.easeInOut));
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
          );
        },
      ),
    ],
    redirect: (context, state) {
      final status = _authBloc.state.status;
      final isLoggedIn = status == AuthenticationStatus.authenticated;
      final isAuthRoute =
          state.matchedLocation == LoginPage.route ||
          state.matchedLocation == RegisterPage.route;

      if (!isLoggedIn && !isAuthRoute) {
        return LoginPage.route;
      }

      if (isLoggedIn && isAuthRoute) {
        return HomePage.route;
      }

      return null;
    },
  );
}

extension ContextRouterExtension on BuildContext {
  GoRouter get router => GoRouter.of(this);
}
