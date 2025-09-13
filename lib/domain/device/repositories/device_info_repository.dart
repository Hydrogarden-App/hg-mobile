import "package:hydrogarden_mobile/domain/device/models/device.dart";

abstract class DeviceInfoRepository {
  Future<List<Device>> getDevices();
  Future<Device> createDevice(Device device);
  Future<Device> updateDevice(Device device);
  Future<void> removeDevice(int id);
}
