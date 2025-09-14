import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hydrogarden_mobile/app/utils/dependency_injection.dart";
import "package:hydrogarden_mobile/data/device/repositories/device_info_repository_local_impl.dart";
import "package:hydrogarden_mobile/data/device/repositories/mocks/device_info_repository_mock.dart";
import "package:hydrogarden_mobile/data/device/repositories/mocks/device_state_repository_mock.dart";
import "package:hydrogarden_mobile/presentation/circuit_list/bloc/circuit_list_bloc.dart";

import "package:hydrogarden_mobile/presentation/circuit_list/views/circuit_list_view.dart";
import "package:hydrogarden_mobile/presentation/connection/bloc/connection_bloc.dart";

class CircuitListPage extends StatelessWidget {
  const CircuitListPage({super.key, required this.deviceId});
  final int deviceId;
  static const route = "circuit_list";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CircuitListBloc>(
      create: (context) => CircuitListBloc(
        localDeviceInfoRepository: getIt<DeviceInfoRepositoryLocalImpl>(),
        remoteDeviceInfoRepository: getIt<DeviceInfoRepositoryMock>(),
        deviceStateRepository: getIt<DeviceStateRepositoryMock>(),
        connectionBloc: context.read<ConnectionBloc>(),
      )..add(CircuitListDataRequested(deviceId)),
      child: CircuitListView(),
    );
  }
}
