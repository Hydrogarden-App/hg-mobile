import "package:flutter/material.dart";
import "package:hydrogarden_mobile/presentation/features/logs/views/logs_view.dart";

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  static const route = "/logs";

  @override
  Widget build(BuildContext context) {
    return LogsView();
  }
}
