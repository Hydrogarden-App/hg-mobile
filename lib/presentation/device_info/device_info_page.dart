import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hydrogarden_mobile/app/utils/dependency_injection.dart";
import "package:hydrogarden_mobile/presentation/connection/bloc/connection_bloc.dart";
import "package:hydrogarden_mobile/presentation/device_info/bloc/device_info_bloc.dart";
import "package:hydrogarden_mobile/presentation/device_info/views/device_info_view.dart";

class DeviceInfoPage extends StatelessWidget {
  final int deviceId;
  const DeviceInfoPage({super.key, required this.deviceId});

  static const route = "device_info";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeviceInfoBloc>(
      create: (context) => DeviceInfoBloc(
        syncManager: getIt.get(),
        connectionBloc: context.read<ConnectionBloc>(),
      )..add(DeviceInfoDataRequested(deviceId)),
      child: DeviceInfoView(deviceId),
    );
  }
}
