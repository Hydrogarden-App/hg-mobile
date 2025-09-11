// Openapi Generator last run: : 2025-09-10T17:02:40.980825
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:hydrogarden_mobile/presentation/features/authentication/pages/login_page.dart";
import "package:hydrogarden_mobile/presentation/features/authentication/pages/register_page.dart";
import "package:openapi_generator_annotations/openapi_generator_annotations.dart";

import "package:hydrogarden_mobile/app/l10n/arb/app_localizations.g.dart";
import "package:hydrogarden_mobile/presentation/features/authentication/bloc/authentication_bloc.dart";
import "package:hydrogarden_mobile/presentation/features/home/home_page.dart";

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: "Hydrogarden Mobile",
        theme: AppTheme().light,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: _router,
      ),
    );
  }
}
