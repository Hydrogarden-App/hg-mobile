import "dart:async";

import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hydrogarden_mobile/data/device/device_sync_manager.dart";
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
    await _syncManager.disableCircuit(event.deviceId, event.id);
  }

  Future<void> _onTurnOnRequested(
    CircuitListTurnOnRequested event,
    Emitter<CircuitListState> emit,
  ) async {
    await _syncManager.enableCircuit(event.deviceId, event.id);
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
    await _syncManager.updateDevice(updatedDevice);
  }

  void _onDeviceUpdated(
    _CircuitListUpdated event,
    Emitter<CircuitListState> emit,
  ) {
    final syncState = event.syncState;
    final device = syncState.devices.isNotEmpty
        ? syncState.devices.first
        : null;

    emit(
      state.copyWith(device: device, isLoading: false, error: syncState.error),
    );

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
