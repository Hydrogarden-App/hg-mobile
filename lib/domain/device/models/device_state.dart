enum DeviceState { alive, dead }

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
