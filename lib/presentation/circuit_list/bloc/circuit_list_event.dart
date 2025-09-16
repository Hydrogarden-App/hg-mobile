part of "circuit_list_bloc.dart";

sealed class CircuitListEvent {
  const CircuitListEvent();
}

final class CircuitListDataRequested extends CircuitListEvent {
  int id;
  CircuitListDataRequested(this.id);
}

final class CircuitListRenameRequested extends CircuitListEvent {
  int deviceId;
  int id;
  String name;
  CircuitListRenameRequested(this.deviceId, this.id, this.name);
}

final class CircuitListTurnOffRequested extends CircuitListEvent {
  int deviceId;
  int id;
  CircuitListTurnOffRequested(this.deviceId, this.id);
}

final class _CircuitListUpdated extends CircuitListEvent {
  final DevicesSyncState syncState;

  const _CircuitListUpdated(this.syncState);
}

final class CircuitListTurnOnRequested extends CircuitListEvent {
  int deviceId;
  int id;
  CircuitListTurnOnRequested(this.deviceId, this.id);
}
