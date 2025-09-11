import "package:flutter/material.dart";

import "package:hydrogarden_mobile/presentation/features/home/views/home_view.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const route = "/home";

  @override
  Widget build(BuildContext context) {
    return HomeView();
  }
}
