import "package:hydrogarden_mobile/domain/device/models/device.dart";

abstract class DeviceStateRepository {
  Future<Device> enableDevice(int deviceId);

  Future<Device> disableDevice(int deviceId);

  Future<Device> enableCircuit(int deviceId, int circuitId);

  Future<Device> disableCircuit(int deviceId, int circuitId);
}
