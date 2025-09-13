import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:connectivity_plus/connectivity_plus.dart";

enum ServerStatus { connected, disconnected }

enum ConnectionStatus { connected, disconnected }

class ConnectionState {
  final ConnectionStatus connectionStatus;
  final ServerStatus serverStatus;

  ConnectionState(this.connectionStatus, this.serverStatus);

  ConnectionState copyWith({
    ConnectionStatus? connectionStatus,
    ServerStatus? serverStatus,
  }) {
    return ConnectionState(
      connectionStatus ?? this.connectionStatus,
      serverStatus ?? this.serverStatus,
    );
  }
}

abstract class ConnectionEvent {}

class ConnectionServerStatusUpdated extends ConnectionEvent {
  final ServerStatus status;
  ConnectionServerStatusUpdated(this.status);
}

class ConnectionNetworkStatusChanged extends ConnectionEvent {
  final ConnectionStatus status;
  ConnectionNetworkStatusChanged(this.status);
}

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionState> {
  final Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectionBloc({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity(),
      super(
        ConnectionState(
          ConnectionStatus.disconnected,
          ServerStatus.disconnected,
        ),
      ) {
    on<ConnectionServerStatusUpdated>(_onServerStatusUpdated);
    on<ConnectionNetworkStatusChanged>(_onNetworkStatusChanged);

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      results,
    ) {
      add(
        ConnectionNetworkStatusChanged(_mapConnectivityResultToStatus(results)),
      );
    });

    _init();
  }

  Future<void> _init() async {
    final result = await _connectivity.checkConnectivity();

    add(ConnectionNetworkStatusChanged(_mapConnectivityResultToStatus(result)));
  }

  void _onServerStatusUpdated(
    ConnectionServerStatusUpdated event,
    Emitter<ConnectionState> emit,
  ) {
    final serverStatus = event.status;

    if (serverStatus == ServerStatus.connected) {
      emit(
        state.copyWith(
          serverStatus: ServerStatus.connected,
          connectionStatus: ConnectionStatus.connected,
        ),
      );
    } else {
      emit(state.copyWith(serverStatus: ServerStatus.disconnected));

      _connectivity.checkConnectivity().then((result) {
        final networkStatus = _mapConnectivityResultToStatus(result);
        emit(state.copyWith(connectionStatus: networkStatus));
      });
    }
  }

  void _onNetworkStatusChanged(
    ConnectionNetworkStatusChanged event,
    Emitter<ConnectionState> emit,
  ) {
    final networkStatus = event.status;
    if (networkStatus == ConnectionStatus.disconnected) {
      emit(
        state.copyWith(
          serverStatus: ServerStatus.disconnected,
          connectionStatus: ConnectionStatus.disconnected,
        ),
      );
    } else {
      emit(state.copyWith(connectionStatus: ConnectionStatus.connected));
    }
  }

  ConnectionStatus _mapConnectivityResultToStatus(
    List<ConnectivityResult> results,
  ) {
    final connectedResults = {
      ConnectivityResult.wifi,
      ConnectivityResult.mobile,
      ConnectivityResult.vpn,
    };

    final isConnected = results.any((r) => connectedResults.contains(r));

    return isConnected
        ? ConnectionStatus.connected
        : ConnectionStatus.disconnected;
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
