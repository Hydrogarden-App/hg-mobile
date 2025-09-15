import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hydrogarden_mobile/domain/device/models/circuit.dart";
import "package:hydrogarden_mobile/domain/device/models/device.dart";
import "package:hydrogarden_mobile/domain/device/repositories/device_info_repository.dart";
import "package:hydrogarden_mobile/domain/device/repositories/device_state_repository.dart";
import "package:hydrogarden_mobile/presentation/connection/bloc/connection_bloc.dart";

part "circuit_list_event.dart";
part "circuit_list_state.dart";

class CircuitListBloc extends Bloc<CircuitListEvent, CircuitListState> {
  final DeviceInfoRepository localDeviceInfoRepository;
  final DeviceInfoRepository remoteDeviceInfoRepository;
  final DeviceStateRepository deviceStateRepository;
  final ConnectionBloc connectionBloc;

  CircuitListBloc({
    required this.localDeviceInfoRepository,
    required this.remoteDeviceInfoRepository,
    required this.deviceStateRepository,
    required this.connectionBloc,
  }) : super(const CircuitListState()) {
    on<CircuitListDataRequested>(_onDataRequested);
    on<CircuitListTurnOffRequested>(_onTurnOffRequested);
    on<CircuitListTurnOnRequested>(_onTurnOnRequested);
    on<CircuitListRenameRequested>(_onRenameRequested);
  }

  Future<void> _onDataRequested(
    CircuitListDataRequested event,
    Emitter<CircuitListState> emit,
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
    CircuitListTurnOffRequested event,
    Emitter<CircuitListState> emit,
  ) async {
    try {
      final updatedDevice = await deviceStateRepository.disableCircuit(
        event.deviceId,
        event.id,
      );
      emit(state.copyWith(device: updatedDevice, error: null));
    } catch (_) {
      emit(state.copyWith(error: "Nie udało się wyłączyć obwodu"));
      connectionBloc.add(
        ConnectionServerStatusUpdated(ServerStatus.disconnected),
      );
    }
  }

  Future<void> _onTurnOnRequested(
    CircuitListTurnOnRequested event,
    Emitter<CircuitListState> emit,
  ) async {
    try {
      final updatedDevice = await deviceStateRepository.enableCircuit(
        event.deviceId,
        event.id,
      );
      emit(state.copyWith(device: updatedDevice, error: null));
    } catch (_) {
      emit(state.copyWith(error: "Nie udało się włączyć obwodu"));
      connectionBloc.add(
        ConnectionServerStatusUpdated(ServerStatus.disconnected),
      );
    }
  }

  Future<void> _onRenameRequested(
    CircuitListRenameRequested event,
    Emitter<CircuitListState> emit,
  ) async {
    final device = state.device?.copyWith();
    if (device == null) return;
    final circuits = device.circuits;
    final idToUpdate = device.circuits.indexWhere(
      (circuit) => circuit.id == event.id,
    );
    if (idToUpdate < 0) return;

    final updatedCircuits = List<Circuit>.from(circuits);
    updatedCircuits[idToUpdate] = circuits[idToUpdate].copyWith(
      name: event.name,
    );

    final updatedDevice = device.copyWith(circuits: updatedCircuits);
    try {
      final result = await remoteDeviceInfoRepository.updateDevice(
        updatedDevice,
      );
      await localDeviceInfoRepository.updateDevice(result);
      emit(state.copyWith(device: result, error: null));
    } catch (_) {
      emit(state.copyWith(error: "Nie udało się zaktualizować nazwy obwodu"));
      connectionBloc.add(
        ConnectionServerStatusUpdated(ServerStatus.disconnected),
      );
    }
  }
}
