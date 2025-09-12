import "package:hydrogarden_mobile/domain/device/models/device_state.dart";
import "package:hydrogarden_mobile/domain/device/models/circuit.dart";
import "package:hydrogarden_mobile/domain/device/models/device.dart";
import "package:hydrogarden_mobile/domain/device/repositories/device_repository.dart";

class DeviceRepositoryMock implements DeviceRepository {
  late Device _mockDevice;

  DeviceRepositoryMock({Device? mockDevice}) {
    _mockDevice = mockDevice ?? _defaultMockDevice();
  }

  static Device _defaultMockDevice() {
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
