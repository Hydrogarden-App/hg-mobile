import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hydrogarden_mobile/presentation/features/authentication/bloc/authentication_bloc.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const route = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            context.read<AuthenticationBloc>().add(
              AuthenticationLogoutRequested(),
            );
          },
          child: Text("logout"),
        ),
      ),
    );
  }
}
