import "dart:async";

import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:connectivity_plus/connectivity_plus.dart";

enum ServerStatus { connected, disconnected }

enum ConnectionStatus { connected, disconnected }

class ConnectionState extends Equatable {
  final ConnectionStatus connectionStatus;
  final ServerStatus serverStatus;

  const ConnectionState(this.connectionStatus, this.serverStatus);

  ConnectionState copyWith({
    ConnectionStatus? connectionStatus,
    ServerStatus? serverStatus,
  }) {
    return ConnectionState(
      connectionStatus ?? this.connectionStatus,
      serverStatus ?? this.serverStatus,
    );
  }

  @override
  List<Object?> get props => [connectionStatus, serverStatus];
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

  ConnectionBloc({required Connectivity connectivity})
    : _connectivity = connectivity,
      super(
        ConnectionState(ConnectionStatus.connected, ServerStatus.connected),
      ) {
    on<ConnectionServerStatusUpdated>(_onServerStatusUpdated);
    on<ConnectionNetworkStatusChanged>(_onNetworkStatusChanged);

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      results,
    ) {
      print("subscription told me to");
      add(
        ConnectionNetworkStatusChanged(_mapConnectivityResultToStatus(results)),
      );
    });

    // _init();
  }

  // Future<void> _init() async {
  //   final result = await _connectivity.checkConnectivity();
  //   print("Init result");

  //   add(ConnectionNetworkStatusChanged(_mapConnectivityResultToStatus(result)));
  // }

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
    }
  }

  void _onNetworkStatusChanged(
    ConnectionNetworkStatusChanged event,
    Emitter<ConnectionState> emit,
  ) {
    final networkStatus = event.status;

    emit(state.copyWith(connectionStatus: networkStatus));
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
