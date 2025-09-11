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
