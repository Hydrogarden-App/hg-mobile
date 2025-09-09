// Openapi Generator last run: : 2025-09-09T22:14:23.113072
import "package:flutter/material.dart";
import "package:hydrogarden_mobile/presentation/features/home/home_page.dart";
import "package:openapi_generator_annotations/openapi_generator_annotations.dart";
import "package:go_router/go_router.dart";

part "router.dart";

@Openapi(
  inputSpec: InputSpec(path: "../hg-openapi/lib/openapi.yaml"),
  outputDirectory: "api",
  generatorName: Generator.dio,
)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Hydrogarden Mobile",
      // theme: appTheme.light,
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router,
    );
  }
}