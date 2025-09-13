import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hydrogarden_mobile/domain/device/models/device.dart";
import "package:hydrogarden_mobile/domain/device/repositories/device_info_repository.dart";
import "package:hydrogarden_mobile/presentation/connection/bloc/connection_bloc.dart";

part "home_event.dart";
part "home_state.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DeviceInfoRepository localDeviceInfoRepository;
  final DeviceInfoRepository remoteDeviceInfoRepository;
  final ConnectionBloc connectionBloc;

  HomeBloc({
    required this.localDeviceInfoRepository,
    required this.remoteDeviceInfoRepository,
    required this.connectionBloc,
  }) : super(const HomeState.loading()) {
    on<HomeDevicesRequested>((event, emit) async {
      emit(HomeState.loading());
      print("waiting for load");

      final devices = await localDeviceInfoRepository.getDevices();
      emit(HomeState.loaded(devices));
      print("loaded local devices ${devices.length}");
      try {
        final remoteDevices = await remoteDeviceInfoRepository.getDevices();
        print("loaded remote devices ${remoteDevices.length}");
        emit(HomeState.loaded(remoteDevices));
        connectionBloc.add(
          ConnectionServerStatusUpdated(ServerStatus.connected),
        );
        final localDeviceIds = devices.map((d) => d.id).toSet();
        final remoteDeviceIds = remoteDevices.map((d) => d.id).toSet();

        for (final device in remoteDevices) {
          if (localDeviceIds.contains(device.id)) {
            await localDeviceInfoRepository.updateDevice(device);
          } else {
            await localDeviceInfoRepository.createDevice(device);
          }
        }

        for (final local in devices) {
          if (!remoteDeviceIds.contains(local.id)) {
            await localDeviceInfoRepository.removeDevice(local.id);
          }
        }
        print("updated local devices");
      } catch (_) {
        connectionBloc.add(
          ConnectionServerStatusUpdated(ServerStatus.disconnected),
        );
        print("dupa");
      }
    });
  }
}
