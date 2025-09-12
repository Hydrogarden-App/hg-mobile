import "package:hive/hive.dart";
import "package:hydrogarden_mobile/domain/device/models/device.dart";
import "package:hydrogarden_mobile/domain/device/repositories/device_info_repository.dart";

class DeviceInfoRepositoryLocalImpl implements DeviceInfoRepository {
  static const String _boxName = "devices";

  Future<Box<Device>> get _box async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<Device>(_boxName);
    }
    return Hive.box<Device>(_boxName);
  }

  @override
  Future<List<Device>> getDevices() async {
    final box = await _box;
    return box.values.toList();
  }

  @override
  Future<Device> createDevice(Device device) async {
    final box = await _box;
    await box.put(device.id, device);
    return device;
  }

  @override
  Future<Device> updateDevice(Device device) async {
    final box = await _box;
    if (!box.containsKey(device.id)) {
      throw Exception("Device with id ${device.id} not found");
    }
    await box.put(device.id, device);
    return device;
  }
}
