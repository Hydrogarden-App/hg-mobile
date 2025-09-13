// Openapi Generator last run: : 2025-09-13T13:45:16.693306
import "package:connectivity_plus/connectivity_plus.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:hydrogarden_mobile/app/utils/dependency_injection.dart";
import "package:hydrogarden_mobile/app/utils/stream_to_listenable.dart";
import "package:hydrogarden_mobile/domain/authentication/authentication_status.dart";
import "package:hydrogarden_mobile/presentation/authentication/pages/login_page.dart";
import "package:hydrogarden_mobile/presentation/authentication/pages/register_page.dart";
import "package:hydrogarden_mobile/presentation/circuit_list/circuit_list_page.dart";
import "package:hydrogarden_mobile/presentation/connection/bloc/connection_bloc.dart";
import "package:hydrogarden_mobile/presentation/device_info/device_info_page.dart";
import "package:hydrogarden_mobile/presentation/logs/logs_page.dart";
import "package:hydrogarden_mobile/presentation/settings/settings_page.dart";
import "package:openapi_generator_annotations/openapi_generator_annotations.dart";

import "package:hydrogarden_mobile/app/l10n/arb/app_localizations.g.dart";
import "package:hydrogarden_mobile/presentation/authentication/bloc/authentication_bloc.dart";
import "package:hydrogarden_mobile/presentation/home/home_page.dart";

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
    final authBloc = getIt<AuthenticationBloc>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>.value(value: authBloc),
        BlocProvider<ConnectionBloc>(
          create: (BuildContext context) =>
              ConnectionBloc(connectivity: getIt<Connectivity>()),
        ),
      ],
      child: MaterialApp.router(
        title: "Hydrogarden Mobile",
        theme: AppTheme().light,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: AppRouter(authBloc).router,
      ),
    );
  }
}