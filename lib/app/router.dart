part of "app.dart";

final _rootNavigatorKey = GlobalKey<NavigatorState>();

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
  ],
);

extension ContexRouterX on BuildContext {
  GoRouter get router => GoRouter.of(this);
}
