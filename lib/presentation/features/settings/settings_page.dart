import "package:flutter/material.dart";

import "package:hydrogarden_mobile/presentation/features/settings/views/settings_view.dart";

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const route = "/settings";

  @override
  Widget build(BuildContext context) {
    return SettingsView();
  }
}
