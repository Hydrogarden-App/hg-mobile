part of "device_info_bloc.dart";

sealed class DeviceInfoEvent {
  const DeviceInfoEvent();
}

final class DeviceInfoDeleteRequested extends DeviceInfoEvent {
  int id;
  DeviceInfoDeleteRequested(this.id);
}

final class DeviceInfoRenameRequested extends DeviceInfoEvent {
  int id;
  String name;
  DeviceInfoRenameRequested(this.id, this.name);
}

final class DeviceInfoDataRequested extends DeviceInfoEvent {
  int id;
  DeviceInfoDataRequested(this.id);
}

final class DeviceInfoTurnOffRequested extends DeviceInfoEvent {
  int id;
  DeviceInfoTurnOffRequested(this.id);
}

final class DeviceInfoTurnOnRequested extends DeviceInfoEvent {
  int id;
  DeviceInfoTurnOnRequested(this.id);
}
