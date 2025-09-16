part of "connection_bloc.dart";

abstract class ConnectionEvent {}

class ConnectionServerStatusUpdated extends ConnectionEvent {
  final ServerStatus status;
  ConnectionServerStatusUpdated(this.status);
}

class ConnectionNetworkStatusChanged extends ConnectionEvent {
  final NetworkStatus status;
  ConnectionNetworkStatusChanged(this.status);
}
