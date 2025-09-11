part of "app.dart";

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final StreamToListenable _authRefresh = StreamToListenable(
  getIt<AuthenticationBloc>().stream,
);

final _router = GoRouter(
  initialLocation: HomePage.route,
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
        return NoTransitionPage(child: const LoginPage());
      },
    ),
    GoRoute(
      path: RegisterPage.route,
      pageBuilder: (context, state) {
        return NoTransitionPage(child: const RegisterPage());
      },
    ),
    GoRoute(
      path: DeviceInfoPage.route,
      pageBuilder: (context, state) {
        return NoTransitionPage(child: const DeviceInfoPage());
      },
    ),
    GoRoute(
      path: CircuitListPage.route,
      pageBuilder: (context, state) {
        return NoTransitionPage(child: const CircuitListPage());
      },
    ),
    GoRoute(
      path: LogsPage.route,
      pageBuilder: (context, state) {
        return NoTransitionPage(child: const LogsPage());
      },
    ),
    GoRoute(
      path: SettingsPage.route,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const SettingsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
  refreshListenable: _authRefresh,
  redirect: (context, state) {
    final loggedIn =
        context.read<AuthenticationBloc>().state.status ==
        AuthenticationStatus.authenticated;
    final loggingIn =
        state.matchedLocation == LoginPage.route ||
        state.matchedLocation == RegisterPage.route;
    if (!loggedIn && !loggingIn) {
      return LoginPage.route;
    }

    if (loggedIn && loggingIn) {
      return HomePage.route;
    }

    return null;
  },
);

extension ContexRouterX on BuildContext {
  GoRouter get router => GoRouter.of(this);
}
