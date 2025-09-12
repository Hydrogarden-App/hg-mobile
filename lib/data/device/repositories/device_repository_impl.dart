import "package:hydrogarden_mobile/data/device/extensions/dto_to_domain_extension.dart";
import "package:hydrogarden_mobile/domain/device/models/device.dart";
import "package:hydrogarden_mobile/domain/device/repositories/device_repository.dart";
import "package:openapi/openapi.dart";

class DeviceRepositoryImpl implements DeviceRepository {
  final DeviceVitalsApi _api;

  DeviceRepositoryImpl(Openapi client) : _api = client.getDeviceVitalsApi();

  @override
  Future<Device> disableCircuit(int deviceId, int circuitId) async {
    final response = await _api.disableCircuit(
      deviceId: deviceId,
      circuitId: circuitId,
    );
    if (response.data != null) return response.data!.toDomain();
    throw Exception();
  }

  @override
  Future<Device> disableDevice(int deviceId) async {
    final response = await _api.disableDevice(deviceId: deviceId);
    if (response.data != null) return response.data!.toDomain();
    throw Exception();
  }

  @override
  Future<Device> enableCircuit(int deviceId, int circuitId) async {
    final response = await _api.enableCircuit(
      deviceId: deviceId,
      circuitId: circuitId,
    );
    if (response.data != null) return response.data!.toDomain();
    throw Exception();
  }

  @override
  Future<Device> enableDevice(int deviceId) async {
    final response = await _api.enableDevice(deviceId: deviceId);
    if (response.data != null) return response.data!.toDomain();
    throw Exception();
  }

  @override
  Future<Device> getDeviceVitals(int deviceId) async {
    final response = await _api.getDeviceVitals(deviceId: deviceId);
    if (response.data != null) return response.data!.toDomain();
    throw Exception();
  }
}
