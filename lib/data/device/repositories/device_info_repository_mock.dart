import "package:hydrogarden_mobile/data/device/mocks/mock_device.dart";
import "package:hydrogarden_mobile/domain/device/models/device.dart";
import "package:hydrogarden_mobile/domain/device/repositories/device_info_repository.dart";

class DeviceInfoRepositoryMock implements DeviceInfoRepository {
  late Device _mockDevice;

  DeviceInfoRepositoryMock({Device? mockDevice}) {
    _mockDevice = mockDevice ?? defaultMockDevice();
  }

  @override
  Future<List<Device>> getDevices() async {
    return [_mockDevice];
  }

  @override
  Future<Device> createDevice(Device device) async {
    return device;
  }

  @override
  Future<Device> updateDevice(Device device) async {
    return device;
  }
}
