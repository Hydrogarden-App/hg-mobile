import "package:hydrogarden_mobile/data/device/extensions/dto_to_domain_extension.dart";
import "package:hydrogarden_mobile/domain/device/models/device.dart";
import "package:hydrogarden_mobile/domain/device/repositories/device_info_repository.dart";
import "package:openapi/openapi.dart";

class DeviceInfoRepositoryRemoteImpl implements DeviceInfoRepository {
  // ignore: unused_field
  final DeviceVitalsApi _api;

  DeviceInfoRepositoryRemoteImpl(Openapi client)
    : _api = client.getDeviceVitalsApi();

  @override
  Future<List<Device>> getDevices() async {
    throw UnimplementedError();
  }

  @override
  Future<Device> createDevice(Device device) {
    throw UnimplementedError();
  }

  @override
  Future<Device> updateDevice(Device device) {
    throw UnimplementedError();
  }

  @override
  Future<void> removeDevice(int id) async {
    throw UnimplementedError();
  }

  @override
  Future<Device> getDeviceInfo(int deviceId) async {
    final response = await _api.getDeviceVitals(deviceId: deviceId);
    if (response.data != null) return response.data!.toDomain();
    throw Exception();
  }
}
