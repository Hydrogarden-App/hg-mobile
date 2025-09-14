import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hydrogarden_mobile/domain/device/models/device.dart";
import "package:hydrogarden_mobile/domain/device/repositories/device_info_repository.dart";
import "package:hydrogarden_mobile/domain/device/repositories/device_state_repository.dart";
import "package:hydrogarden_mobile/presentation/connection/bloc/connection_bloc.dart";

part "device_info_event.dart";
part "device_info_state.dart";

class DeviceInfoBloc extends Bloc<DeviceInfoEvent, DeviceInfoState> {
  final DeviceInfoRepository localDeviceInfoRepository;
  final DeviceInfoRepository remoteDeviceInfoRepository;
  final DeviceStateRepository deviceStateRepository;
  final ConnectionBloc connectionBloc;

  DeviceInfoBloc({
    required this.localDeviceInfoRepository,
    required this.remoteDeviceInfoRepository,
    required this.deviceStateRepository,
    required this.connectionBloc,
  }) : super(const DeviceInfoState()) {
    on<DeviceInfoDataRequested>(_onDataRequested);
    on<DeviceInfoTurnOffRequested>(_onTurnOffRequested);
    on<DeviceInfoTurnOnRequested>(_onTurnOnRequested);
    on<DeviceInfoRenameRequested>(_onRenameRequested);
  }

  Future<void> _onDataRequested(
    DeviceInfoDataRequested event,
    Emitter<DeviceInfoState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final localDevice = await localDeviceInfoRepository.getDeviceInfo(
        event.id,
      );
      emit(state.copyWith(device: localDevice));
    } catch (e) {
      emit(state.copyWith(error: "Błąd lokalnego odczytu", isLoading: false));
    }

    try {
      final remoteDevice = await remoteDeviceInfoRepository.getDeviceInfo(
        event.id,
      );
      emit(state.copyWith(device: remoteDevice, isLoading: false, error: null));
      await localDeviceInfoRepository.updateDevice(remoteDevice);
      connectionBloc.add(ConnectionServerStatusUpdated(ServerStatus.connected));
    } catch (_) {
      emit(
        state.copyWith(
          error: "Nie udało się pobrać danych z serwera",
          isLoading: false,
        ),
      );
      connectionBloc.add(
        ConnectionServerStatusUpdated(ServerStatus.disconnected),
      );
    }
  }

  Future<void> _onTurnOffRequested(
    DeviceInfoTurnOffRequested event,
    Emitter<DeviceInfoState> emit,
  ) async {
    try {
      final updatedDevice = await deviceStateRepository.disableDevice(event.id);
      emit(state.copyWith(device: updatedDevice, error: null));
    } catch (_) {
      emit(state.copyWith(error: "Nie udało się wyłączyć urządzenia"));
      connectionBloc.add(
        ConnectionServerStatusUpdated(ServerStatus.disconnected),
      );
    }
  }

  Future<void> _onTurnOnRequested(
    DeviceInfoTurnOnRequested event,
    Emitter<DeviceInfoState> emit,
  ) async {
    try {
      final updatedDevice = await deviceStateRepository.enableDevice(event.id);
      emit(state.copyWith(device: updatedDevice, error: null));
    } catch (_) {
      emit(state.copyWith(error: "Nie udało się włączyć urządzenia"));
      connectionBloc.add(
        ConnectionServerStatusUpdated(ServerStatus.disconnected),
      );
    }
  }

  Future<void> _onRenameRequested(
    DeviceInfoRenameRequested event,
    Emitter<DeviceInfoState> emit,
  ) async {
    final updatedDevice = state.device?.copyWith(name: event.name);
    if (updatedDevice == null) return;

    try {
      final result = await remoteDeviceInfoRepository.updateDevice(
        updatedDevice,
      );
      await localDeviceInfoRepository.updateDevice(result);
      emit(state.copyWith(device: result, error: null));
    } catch (_) {
      emit(state.copyWith(error: "Nie udało się zaktualizować nazwy"));
      connectionBloc.add(
        ConnectionServerStatusUpdated(ServerStatus.disconnected),
      );
    }
  }
}
