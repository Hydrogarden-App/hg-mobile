import "package:hive/hive.dart";

part "device_state.g.dart";

@HiveType(typeId: 2)
enum DeviceState {
  @HiveField(0)
  alive,

  @HiveField(1)
  dead,
}

extension DeviceStateX on DeviceState {
  static DeviceState fromString(String value) {
    switch (value.toLowerCase()) {
      case "alive":
        return DeviceState.alive;
      case "dead":
        return DeviceState.dead;
      default:
        throw ArgumentError("Invalid DeviceState: $value");
    }
  }

  String toJson() => name.toUpperCase();
}
