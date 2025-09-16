part of "connection_bloc.dart";

enum ServerStatus { connected, disconnected }

enum NetworkStatus { connected, disconnected }

class ConnectionState extends Equatable {
  final NetworkStatus networkStatus;
  final ServerStatus serverStatus;

  const ConnectionState(this.networkStatus, this.serverStatus);

  ConnectionState copyWith({
    NetworkStatus? networkStatus,
    ServerStatus? serverStatus,
  }) {
    return ConnectionState(
      networkStatus ?? this.networkStatus,
      serverStatus ?? this.serverStatus,
    );
  }

  @override
  List<Object?> get props => [networkStatus, serverStatus];
}
