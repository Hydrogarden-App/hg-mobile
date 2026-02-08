// Openapi Generator last run: : 2026-02-02T22:13:07.794166
import "package:clerk_flutter/clerk_flutter.dart";
import "package:connectivity_plus/connectivity_plus.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:go_router/go_router.dart";
import "package:openapi_generator_annotations/openapi_generator_annotations.dart";

import "package:hydrogarden_mobile/app/datasource/remote/client_provider.dart";
import "package:hydrogarden_mobile/app/l10n/arb/app_localizations.g.dart";
import "package:hydrogarden_mobile/app/services/deeplink_handler.dart";
import "package:hydrogarden_mobile/app/utils/dependency_injection.dart";
import "package:hydrogarden_mobile/app/utils/stream_to_listenable.dart";
import "package:hydrogarden_mobile/domain/authentication/authentication_status.dart";
import "package:hydrogarden_mobile/presentation/authentication/bloc/authentication_bloc.dart";
import "package:hydrogarden_mobile/presentation/authentication/pages/login_page.dart";
import "package:hydrogarden_mobile/presentation/circuit_list/circuit_list_page.dart";
import "package:hydrogarden_mobile/presentation/connection/bloc/connection_bloc.dart";
import "package:hydrogarden_mobile/presentation/device_info/device_info_page.dart";
import "package:hydrogarden_mobile/presentation/home/home_page.dart";
import "package:hydrogarden_mobile/presentation/logs/logs_page.dart";
import "package:hydrogarden_mobile/presentation/settings/settings_page.dart";
import "theme/app_theme.dart";

part "router.dart";

@Openapi(
  inputSpec: InputSpec(path: "../hg-openapi/lib/openapi.yaml"),
  outputDirectory: "../openapi",
  generatorName: Generator.dio,
)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ClerkAuth(
      config: ClerkAuthConfig(
        redirectionGenerator: DeepLinkHandler.generateDeepLink,
        deepLinkStream: DeepLinkHandler.getDeepLinkStream(),
        publishableKey: dotenv.env["CLERK_PUBLISHABLE_KEY"]!,
      ),
      child: ClerkAuthBuilder(
        builder: (context, clerkAuthState) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<AuthenticationBloc>(
                create: (context) => AuthenticationBloc(
                  clerkAuth: clerkAuthState,
                  clientProvider: getIt<ClientProvider>(),
                ),
              ),
              BlocProvider<ConnectionBloc>(
                create: (BuildContext context) =>
                    ConnectionBloc(connectivity: getIt<Connectivity>()),
              ),
            ],
            child: Builder(
              builder: (innerContext) {
                final appRouter = AppRouter(
                  innerContext.read<AuthenticationBloc>(),
                ).router;

                return MaterialApp.router(
                  title: "Hydrogarden Mobile",
                  theme: AppTheme().light,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  routerConfig: appRouter,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
