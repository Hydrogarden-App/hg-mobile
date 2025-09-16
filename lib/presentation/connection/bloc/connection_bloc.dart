import "dart:async";

import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:connectivity_plus/connectivity_plus.dart";

part "connection_event.dart";
part "connection_state.dart";

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionState> {
  final Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectionBloc({required Connectivity connectivity})
    : _connectivity = connectivity,
      super(ConnectionState(NetworkStatus.connected, ServerStatus.connected)) {
    on<ConnectionServerStatusUpdated>(_onServerStatusUpdated);
    on<ConnectionNetworkStatusChanged>(_onNetworkStatusChanged);

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      results,
    ) {
      add(
        ConnectionNetworkStatusChanged(_mapConnectivityResultToStatus(results)),
      );
    });
  }

  void _onServerStatusUpdated(
    ConnectionServerStatusUpdated event,
    Emitter<ConnectionState> emit,
  ) {
    final serverStatus = event.status;

    emit(state.copyWith(serverStatus: serverStatus));
  }

  void _onNetworkStatusChanged(
    ConnectionNetworkStatusChanged event,
    Emitter<ConnectionState> emit,
  ) {
    final networkStatus = event.status;
    if (networkStatus == NetworkStatus.connected) {
      emit(state.copyWith(networkStatus: networkStatus));
    } else {
      emit(
        state.copyWith(
          networkStatus: networkStatus,
          serverStatus: ServerStatus.disconnected,
        ),
      );
    }
  }

  NetworkStatus _mapConnectivityResultToStatus(
    List<ConnectivityResult> results,
  ) {
    final connectedResults = {
      ConnectivityResult.wifi,
      ConnectivityResult.mobile,
      ConnectivityResult.vpn,
    };

    final isConnected = results.any((r) => connectedResults.contains(r));

    return isConnected ? NetworkStatus.connected : NetworkStatus.disconnected;
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
