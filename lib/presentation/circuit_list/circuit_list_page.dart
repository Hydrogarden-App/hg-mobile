import "package:flutter/material.dart";

import "package:hydrogarden_mobile/presentation/circuit_list/views/circuit_list_view.dart";

class CircuitListPage extends StatelessWidget {
  const CircuitListPage({super.key});

  static const route = "/circuit_list";

  @override
  Widget build(BuildContext context) {
    return CircuitListView();
  }
}
