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
        name: "home",
        path: HomePage.route,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: HomePage()),
        routes: [
          GoRoute(
            name: DeviceInfoPage.route,
            path: "${DeviceInfoPage.route}/:id",
            pageBuilder: (context, state) {
              final deviceId = state.pathParameters["id"]!;
              return NoTransitionPage(
                child: DeviceInfoPage(deviceId: int.parse(deviceId)),
              );
            },
            routes: [
              GoRoute(
                name: CircuitListPage.route,
                path: CircuitListPage.route,
                pageBuilder: (context, state) {
                  final deviceId = int.parse(state.pathParameters["id"]!);
                  return NoTransitionPage(
                    child: CircuitListPage(deviceId: deviceId),
                  );
                },
              ),
              GoRoute(
                name: LogsPage.route,
                path: LogsPage.route,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: LogsPage()),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: LoginPage.route,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: LoginPage()),
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
      final isAuthRoute = state.matchedLocation == LoginPage.route;

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
