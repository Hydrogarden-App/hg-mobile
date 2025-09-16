part of "home_bloc.dart";

sealed class HomeEvent {
  const HomeEvent();
}

final class HomeDeviceAdded extends HomeEvent {
  int id;
  String name;
  HomeDeviceAdded(this.id, this.name);
}

final class HomeDeviceRemoved extends HomeEvent {
  int id;
  HomeDeviceRemoved(this.id);
}

final class HomeDevicesRequested extends HomeEvent {}

class HomeDevicesSyncRequested extends HomeEvent {}

class _HomeDevicesUpdated extends HomeEvent {
  final DevicesSyncState syncState;

  const _HomeDevicesUpdated(this.syncState);
}
