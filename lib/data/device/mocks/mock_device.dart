import "package:hydrogarden_mobile/domain/device/models/circuit.dart";
import "package:hydrogarden_mobile/domain/device/models/device.dart";
import "package:hydrogarden_mobile/domain/device/models/device_state.dart";

Device defaultMockDevice() {
  final now = DateTime.now();
  return Device(
    id: 1,
    name: "Test Device",
    state: DeviceState.alive,
    desiredState: DeviceState.alive,
    lastKeepAliveSendTime: now.subtract(const Duration(minutes: 2)),
    lastHeartbeatReceiveTime: now.subtract(const Duration(minutes: 1)),
    circuits: [
      Circuit(id: 1, name: "Pomidorki", state: true, desiredState: true),
      Circuit(id: 2, name: "Cebulka", state: false, desiredState: false),
    ],
  );
}
