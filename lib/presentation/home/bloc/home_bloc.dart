import "dart:async";

import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hydrogarden_mobile/data/device/device_sync_manager.dart";
import "package:hydrogarden_mobile/domain/device/models/device.dart";
import "package:hydrogarden_mobile/presentation/connection/bloc/connection_bloc.dart";

part "home_event.dart";
part "home_state.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DeviceSyncManager _syncManager;
  final ConnectionBloc _connectionBloc;
  StreamSubscription? _subscription;

  HomeBloc({
    required DeviceSyncManager syncManager,
    required ConnectionBloc connectionBloc,
  }) : _syncManager = syncManager,
       _connectionBloc = connectionBloc,
       super(const HomeState.loading()) {
    on<HomeDevicesRequested>(_onDevicesRequested);

    on<HomeDevicesSyncRequested>(_onDevicesSyncRequested);

    on<_HomeDevicesUpdated>(_onDevicesUpdated);
  }

  Future<void> _onDevicesRequested(
    HomeDevicesRequested event,
    Emitter<HomeState> emit,
  ) async {
    await _subscription?.cancel();

    _subscription = _syncManager.watchDevices().listen((syncState) {
      add(_HomeDevicesUpdated(syncState));
    });
  }

  Future<void> _onDevicesSyncRequested(
    HomeDevicesSyncRequested event,
    Emitter<HomeState> emit,
  ) async {
    await _syncManager.syncDevices();
  }

  void _onDevicesUpdated(_HomeDevicesUpdated event, Emitter<HomeState> emit) {
    final syncState = event.syncState;

    print("update happened");

    emit(HomeState.loaded(syncState.devices));

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
