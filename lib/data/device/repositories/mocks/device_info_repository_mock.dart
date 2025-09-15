import "dart:math";

import "package:hydrogarden_mobile/data/device/mocks/mock_device.dart";
import "package:hydrogarden_mobile/domain/device/models/device.dart";
import "package:hydrogarden_mobile/domain/device/repositories/device_info_repository.dart";

final _random = Random();

class DeviceInfoRepositoryMock implements DeviceInfoRepository {
  late Device _mockDevice;

  DeviceInfoRepositoryMock({Device? mockDevice}) {
    _mockDevice = mockDevice ?? defaultMockDevice();
  }

  @override
  Future<List<Device>> getDevices() async {
    final delay = Duration(milliseconds: 100 + _random.nextInt(2000));
    await Future.delayed(delay);

    final count = 1 + _random.nextInt(10);
    return List.generate(
      count,
      (index) =>
          _mockDevice.copyWith(id: index, name: "${_mockDevice.name} $index"),
    );
    // throw Exception();
  }

  @override
  Future<Device> createDevice(Device device) async {
    return device;
  }

  @override
  Future<Device> updateDevice(Device device) async {
    return device;
  }

  @override
  Future<void> removeDevice(int id) async {}

  @override
  Future<Device> getDeviceInfo(int deviceId) async {
    final delay = Duration(milliseconds: 100 + _random.nextInt(2000));
    await Future.delayed(delay);
    return _mockDevice.copyWith(id: deviceId);
    // throw Exception();
  }
}
