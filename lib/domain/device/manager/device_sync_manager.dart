import "dart:async";
import "package:hydrogarden_mobile/domain/device/models/device.dart";
import "package:hydrogarden_mobile/domain/device/repositories/device_info_repository.dart";
import "package:hydrogarden_mobile/domain/device/repositories/device_state_repository.dart";
import "package:rxdart/rxdart.dart";

part "device_sync_state.dart";
part "device_sync_helpers.dart";

class DeviceSyncManager {
  final DeviceInfoRepository localDeviceInfoRepository;
  final DeviceInfoRepository remoteDeviceInfoRepository;
  final DeviceStateRepository deviceStateRepository;

  final BehaviorSubject<DevicesSyncState> _controller =
      BehaviorSubject<DevicesSyncState>.seeded(
        const DevicesSyncState(devices: [], isConnected: false),
      );

  List<Device> _currentDevices = [];

  DeviceSyncManager({
    required this.localDeviceInfoRepository,
    required this.remoteDeviceInfoRepository,
    required this.deviceStateRepository,
  }) {
    _load();
  }

  Stream<DevicesSyncState> watchDevices() => _controller.stream;

  Stream<DevicesSyncState> watchDevice(int deviceId) {
    return watchDevices().map((state) {
      final device = state.devices.where((d) => d.id == deviceId).firstOrNull;
      return state.copyWith(devices: device != null ? [device] : const []);
    });
  }

  Future<void> syncDevices() async {
    try {
      final remoteDevices = await remoteDeviceInfoRepository.getDevices();
      final localDevices = await localDeviceInfoRepository.getDevices();

      await _syncLocalWithRemote(localDevices, remoteDevices);
      _currentDevices = remoteDevices;
      _emit(devices: remoteDevices, isConnected: true);
    } catch (e) {
      final localDevices = await localDeviceInfoRepository.getDevices();
      _currentDevices = localDevices;
      _emit(
        devices: localDevices,
        isConnected: false,
        error: "Sync failed: $e",
      );
      rethrow;
    }
  }

  Future<void> disableCircuit(int deviceId, int circuitId) async {
    try {
      final updated = await deviceStateRepository.disableCircuit(
        deviceId,
        circuitId,
      );
      final updatedDevices = _currentDevices.map((d) {
        return d.id == updated.id ? updated : d;
      }).toList();
      _currentDevices = updatedDevices;
      _emit(devices: updatedDevices, isConnected: true);
    } catch (e) {
      _emit(devices: _currentDevices, isConnected: false, error: e);
      rethrow;
    }
  }

  Future<void> disableDevice(int deviceId) async {
    try {
      final updated = await deviceStateRepository.disableDevice(deviceId);
      final updatedDevices = _currentDevices.map((d) {
        return d.id == updated.id ? updated : d;
      }).toList();
      _currentDevices = updatedDevices;
      _emit(devices: updatedDevices, isConnected: true);
    } catch (e) {
      _emit(devices: _currentDevices, isConnected: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> enableCircuit(int deviceId, int circuitId) async {
    try {
      final updated = await deviceStateRepository.enableCircuit(
        deviceId,
        circuitId,
      );
      final updatedDevices = _currentDevices.map((d) {
        return d.id == updated.id ? updated : d;
      }).toList();
      _currentDevices = updatedDevices;
      _emit(devices: updatedDevices, isConnected: true);
    } catch (e) {
      _emit(devices: _currentDevices, isConnected: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> enableDevice(int deviceId) async {
    try {
      final updated = await deviceStateRepository.enableDevice(deviceId);
      final updatedDevices = _currentDevices.map((d) {
        return d.id == updated.id ? updated : d;
      }).toList();
      _currentDevices = updatedDevices;
      _emit(devices: updatedDevices, isConnected: true);
    } catch (e) {
      _emit(devices: _currentDevices, isConnected: false, error: e);
      rethrow;
    }
  }

  Future<void> createDevice(Device device) async {
    try {
      final created = await remoteDeviceInfoRepository.createDevice(device);
      await localDeviceInfoRepository.createDevice(created);
      _currentDevices.add(created);
      _emit(devices: _currentDevices, isConnected: true);
    } catch (e) {
      _emit(devices: _currentDevices, isConnected: false, error: e);
      rethrow;
    }
  }

  Future<void> updateDevice(Device device) async {
    try {
      final updated = await remoteDeviceInfoRepository.updateDevice(device);
      await localDeviceInfoRepository.updateDevice(updated);
      final updatedDevices = _currentDevices.map((d) {
        return d.id == updated.id ? updated : d;
      }).toList();
      _currentDevices = updatedDevices;
      _emit(devices: updatedDevices, isConnected: true);
    } catch (e) {
      _emit(devices: _currentDevices, isConnected: false, error: e);
      rethrow;
    }
  }

  Future<void> removeDevice(int id) async {
    try {
      await remoteDeviceInfoRepository.removeDevice(id);
      await localDeviceInfoRepository.removeDevice(id);
      _currentDevices.removeWhere((d) => d.id == id);
      _emit(devices: _currentDevices, isConnected: true);
    } catch (e) {
      _emit(devices: _currentDevices, isConnected: false, error: e);
      rethrow;
    }
  }

  void dispose() {
    _controller.close();
  }
}
