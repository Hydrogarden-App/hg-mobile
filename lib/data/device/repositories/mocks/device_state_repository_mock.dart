import "package:hydrogarden_mobile/data/device/mocks/mock_device.dart";
import "package:hydrogarden_mobile/domain/device/models/device_state.dart";
import "package:hydrogarden_mobile/domain/device/models/device.dart";
import "package:hydrogarden_mobile/domain/device/repositories/device_state_repository.dart";

class DeviceStateRepositoryMock implements DeviceStateRepository {
  late Device _mockDevice;

  DeviceStateRepositoryMock({Device? mockDevice}) {
    _mockDevice = mockDevice ?? defaultMockDevice();
  }

  @override
  Future<Device> enableDevice(int deviceId) async {
    _mockDevice = _mockDevice.copyWith(
      id: deviceId,
      name: "Test Device $deviceId",
      desiredState: DeviceState.alive,
      state: DeviceState.alive,
    );

    return _mockDevice;
  }

  @override
  Future<Device> disableDevice(int deviceId) async {
    _mockDevice = _mockDevice.copyWith(
      id: deviceId,
      name: "Test Device $deviceId",
      desiredState: DeviceState.dead,
      state: DeviceState.dead,
    );

    return _mockDevice;
  }

  @override
  Future<Device> enableCircuit(int deviceId, int circuitId) async {
    final updatedCircuits = _mockDevice.circuits.map((circuit) {
      if (circuit.id == circuitId) {
        return circuit.copyWith(desiredState: true, state: true);
      }
      return circuit;
    }).toList();

    _mockDevice = _mockDevice.copyWith(
      id: deviceId,
      name: "Test Device $deviceId",
      circuits: updatedCircuits,
    );

    return _mockDevice;
  }

  @override
  Future<Device> disableCircuit(int deviceId, int circuitId) async {
    final updatedCircuits = _mockDevice.circuits.map((circuit) {
      if (circuit.id == circuitId) {
        return circuit.copyWith(desiredState: false, state: false);
      }
      return circuit;
    }).toList();

    _mockDevice = _mockDevice.copyWith(
      id: deviceId,
      name: "Test Device $deviceId",
      circuits: updatedCircuits,
    );

    return _mockDevice;
  }
}
