import "package:flutter/material.dart";
import "package:hydrogarden_mobile/app/app.dart";
import "package:hydrogarden_mobile/app/utils/dependency_injection.dart";
import "package:hydrogarden_mobile/app/datasource/local/hive.dart";

void main() async {
  await setupHive();
  setupGetIt();
  runApp(const MyApp());
}
