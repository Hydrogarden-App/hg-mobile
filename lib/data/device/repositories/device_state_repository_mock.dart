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
  Future<Device> getDeviceVitals(int deviceId) async {
    return _mockDevice;
  }

  @override
  Future<Device> enableDevice(int deviceId) async {
    if (_mockDevice.id == deviceId) {
      _mockDevice = _mockDevice.copyWith(
        desiredState: DeviceState.alive,
        state: DeviceState.alive,
      );
    }
    return _mockDevice;
  }

  @override
  Future<Device> disableDevice(int deviceId) async {
    if (_mockDevice.id == deviceId) {
      _mockDevice = _mockDevice.copyWith(
        desiredState: DeviceState.dead,
        state: DeviceState.dead,
      );
    }
    return _mockDevice;
  }

  @override
  Future<Device> enableCircuit(int deviceId, int circuitId) async {
    if (_mockDevice.id == deviceId) {
      final updatedCircuits = _mockDevice.circuits.map((circuit) {
        if (circuit.id == circuitId) {
          return circuit.copyWith(desiredState: true, state: true);
        }
        return circuit;
      }).toList();

      _mockDevice = _mockDevice.copyWith(circuits: updatedCircuits);
    }
    return _mockDevice;
  }

  @override
  Future<Device> disableCircuit(int deviceId, int circuitId) async {
    if (_mockDevice.id == deviceId) {
      final updatedCircuits = _mockDevice.circuits.map((circuit) {
        if (circuit.id == circuitId) {
          return circuit.copyWith(desiredState: false, state: false);
        }
        return circuit;
      }).toList();

      _mockDevice = _mockDevice.copyWith(circuits: updatedCircuits);
    }
    return _mockDevice;
  }
}
