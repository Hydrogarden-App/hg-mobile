import "dart:async";

import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hydrogarden_mobile/domain/device/manager/device_sync_manager.dart";
import "package:hydrogarden_mobile/domain/device/models/circuit.dart";
import "package:hydrogarden_mobile/domain/device/models/device.dart";
import "package:hydrogarden_mobile/presentation/connection/bloc/connection_bloc.dart";

part "circuit_list_event.dart";
part "circuit_list_state.dart";

class CircuitListBloc extends Bloc<CircuitListEvent, CircuitListState> {
  final DeviceSyncManager _syncManager;
  final ConnectionBloc _connectionBloc;
  StreamSubscription? _subscription;

  CircuitListBloc({
    required DeviceSyncManager syncManager,
    required ConnectionBloc connectionBloc,
  }) : _syncManager = syncManager,
       _connectionBloc = connectionBloc,
       super(const CircuitListState()) {
    on<CircuitListDataRequested>(_onDataRequested);
    on<CircuitListTurnOffRequested>(_onTurnOffRequested);
    on<CircuitListTurnOnRequested>(_onTurnOnRequested);
    on<CircuitListRenameRequested>(_onRenameRequested);

    on<_CircuitListUpdated>(_onDeviceUpdated);
  }

  Future<void> _onDataRequested(
    CircuitListDataRequested event,
    Emitter<CircuitListState> emit,
  ) async {
    await _subscription?.cancel();

    _subscription = _syncManager.watchDevice(event.id).listen((syncState) {
      add(_CircuitListUpdated(syncState));
    });
  }

  Future<void> _onTurnOffRequested(
    CircuitListTurnOffRequested event,
    Emitter<CircuitListState> emit,
  ) async {
    try {
      await _syncManager.disableCircuit(event.deviceId, event.id);
    } catch (e) {
      emit(
        state.copyWith(
          device: state.device,
          isLoading: false,
          error: "Nie udało się wyłączyć obwodu",
        ),
      );
    }
  }

  Future<void> _onTurnOnRequested(
    CircuitListTurnOnRequested event,
    Emitter<CircuitListState> emit,
  ) async {
    try {
      await _syncManager.enableCircuit(event.deviceId, event.id);
    } catch (e) {
      emit(
        state.copyWith(
          device: state.device,
          isLoading: false,
          error: "Nie udało się włączyć obwodu",
        ),
      );
    }
  }

  Future<void> _onRenameRequested(
    CircuitListRenameRequested event,
    Emitter<CircuitListState> emit,
  ) async {
    final currentDevice = state.device;
    if (currentDevice == null) return;

    final updatedCircuits = currentDevice.circuits.map((circuit) {
      return circuit.id == event.id
          ? circuit.copyWith(name: event.name)
          : circuit;
    }).toList();

    final updatedDevice = currentDevice.copyWith(circuits: updatedCircuits);
    try {
      await _syncManager.updateDevice(updatedDevice);
    } catch (e) {
      emit(
        state.copyWith(
          device: state.device,
          isLoading: false,
          error:
              "Brak połączenia z serwerem, nie można zaktualizować nazwy obwodu.",
        ),
      );
    }
  }

  void _onDeviceUpdated(
    _CircuitListUpdated event,
    Emitter<CircuitListState> emit,
  ) {
    final syncState = event.syncState;
    final device = syncState.devices.isNotEmpty
        ? syncState.devices.first
        : null;

    emit(state.copyWith(device: device, isLoading: false, error: null));

    _connectionBloc.add(
      ConnectionServerStatusUpdated(
        syncState.isConnected
            ? ServerStatus.connected
            : ServerStatus.disconnected,
      ),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
