// Openapi Generator last run: : 2025-09-10T16:08:44.431163
import "package:flutter/material.dart";
import "package:hydrogarden_mobile/app/l10n/arb/app_localizations.g.dart";
import "package:hydrogarden_mobile/presentation/features/home/home_page.dart";
import "package:openapi_generator_annotations/openapi_generator_annotations.dart";
import "package:go_router/go_router.dart";
import "theme/app_theme.dart";

part "router.dart";

@Openapi(
  inputSpec: InputSpec(path: "../hg-openapi/lib/openapi.yaml"),
  outputDirectory: "lib/api",
  generatorName: Generator.dio,
)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Hydrogarden Mobile",
      theme: AppTheme().light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router,
    );
  }
}