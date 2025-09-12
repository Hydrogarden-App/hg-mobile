import "package:openapi/openapi.dart";
import "package:hydrogarden_mobile/domain/device/models/device.dart";
import "package:hydrogarden_mobile/domain/device/models/circuit.dart";
import "package:hydrogarden_mobile/domain/device/models/device_state.dart"
    as domain_state;

extension DeviceVitalsViewModelX on DeviceVitalsViewModel {
  Device toDomain() {
    return Device(
      id: id,
      name: name,
      state: state.toDomain(),
      desiredState: desiredState.toDomain(),
      lastKeepAliveSendTime: _parseDate(lastKeepAliveSendTime),
      lastHeartbeatReceiveTime: _parseDate(lastHeartbeatReceiveTime),
      circuits: circuits.map((c) => c.toDomain()).toList(),
    );
  }
}

extension CircuitVitalsViewModelX on CircuitVitalsViewModel {
  Circuit toDomain() {
    return Circuit(
      id: id,
      name: name,
      state: state,
      desiredState: desiredState,
    );
  }
}

extension DeviceStateX on DeviceState {
  domain_state.DeviceState toDomain() {
    return (this == DeviceState.ALIVE)
        ? domain_state.DeviceState.alive
        : domain_state.DeviceState.dead;
  }
}

DateTime _parseDate(Date openApiDate) {
  return DateTime.parse(openApiDate.toString());
}
