import "dart:async";

import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hydrogarden_mobile/data/device/device_sync_manager.dart";
import "package:hydrogarden_mobile/domain/device/models/device.dart";
import "package:hydrogarden_mobile/presentation/connection/bloc/connection_bloc.dart";

part "device_info_event.dart";
part "device_info_state.dart";

class DeviceInfoBloc extends Bloc<DeviceInfoEvent, DeviceInfoState> {
  final DeviceSyncManager _syncManager;
  final ConnectionBloc _connectionBloc;
  StreamSubscription? _subscription;

  DeviceInfoBloc({
    required DeviceSyncManager syncManager,
    required ConnectionBloc connectionBloc,
  }) : _syncManager = syncManager,
       _connectionBloc = connectionBloc,
       super(const DeviceInfoState()) {
    on<DeviceInfoDataRequested>(_onDataRequested);
    on<DeviceInfoTurnOffRequested>(_onTurnOffRequested);
    on<DeviceInfoTurnOnRequested>(_onTurnOnRequested);
    on<DeviceInfoRenameRequested>(_onRenameRequested);

    on<_DeviceInfoUpdated>(_onDeviceUpdated);
  }

  Future<void> _onDataRequested(
    DeviceInfoDataRequested event,
    Emitter<DeviceInfoState> emit,
  ) async {
    await _subscription?.cancel();

    _subscription = _syncManager.watchDevice(event.id).listen((syncState) {
      add(_DeviceInfoUpdated(syncState));
    });
  }

  Future<void> _onTurnOffRequested(
    DeviceInfoTurnOffRequested event,
    Emitter<DeviceInfoState> emit,
  ) async {
    await _syncManager.disableDevice(event.id);
  }

  Future<void> _onTurnOnRequested(
    DeviceInfoTurnOnRequested event,
    Emitter<DeviceInfoState> emit,
  ) async {
    await _syncManager.enableDevice(event.id);
  }

  Future<void> _onRenameRequested(
    DeviceInfoRenameRequested event,
    Emitter<DeviceInfoState> emit,
  ) async {
    final current = state.device;
    if (current == null) return;

    final renamed = current.copyWith(name: event.name);
    await _syncManager.updateDevice(renamed);
  }

  void _onDeviceUpdated(
    _DeviceInfoUpdated event,
    Emitter<DeviceInfoState> emit,
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
