import "package:flutter/material.dart" hide ConnectionState;
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hydrogarden_mobile/app/app.dart";
import "package:hydrogarden_mobile/app/utils/dependency_injection.dart";
import "package:hydrogarden_mobile/presentation/connection/bloc/connection_bloc.dart";
import "package:hydrogarden_mobile/presentation/device_info/device_info_page.dart";
import "package:hydrogarden_mobile/presentation/home/bloc/home_bloc.dart";

import "package:hydrogarden_mobile/presentation/home/views/home_view.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const route = "/";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(
        syncManager: getIt.get(),
        connectionBloc: context.read<ConnectionBloc>(),
      )..add(HomeDevicesRequested()),
      child: BlocListener<ConnectionBloc, ConnectionState>(
        listenWhen: (previous, state) {
          return previous.networkStatus != state.networkStatus &&
              state.networkStatus == NetworkStatus.connected;
        },
        listener: (context, state) {
          print("syncing after reconnect");
          context.read<HomeBloc>().add(HomeDevicesSyncRequested());
        },
        child: HomeView(
          navigateToDevice: (id) => context.router.pushNamed(
            DeviceInfoPage.route,
            pathParameters: {"id": id.toString()},
          ),
        ),
      ),
    );
  }
}
