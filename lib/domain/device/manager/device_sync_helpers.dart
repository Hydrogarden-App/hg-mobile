part of "device_sync_manager.dart";

extension DeviceSyncHelpers on DeviceSyncManager {
  Future<void> _syncLocalWithRemote(
    List<Device> localDevices,
    List<Device> remoteDevices,
  ) async {
    final localIds = localDevices.map((d) => d.id).toSet();
    final remoteIds = remoteDevices.map((d) => d.id).toSet();

    for (final device in remoteDevices) {
      if (localIds.contains(device.id)) {
        await localDeviceInfoRepository.updateDevice(device);
      } else {
        await localDeviceInfoRepository.createDevice(device);
      }
    }

    for (final local in localDevices) {
      if (!remoteIds.contains(local.id)) {
        await localDeviceInfoRepository.removeDevice(local.id);
      }
    }
  }

  Future<void> _load() async {
    final localDevices = await localDeviceInfoRepository.getDevices();
    _currentDevices = localDevices;
    _emit(devices: localDevices, isConnected: false);
    print("got ${localDevices.length} from local");
    try {
      final remoteDevices = await remoteDeviceInfoRepository.getDevices();
      print("got remote ${remoteDevices.length}");
      _syncLocalWithRemote(localDevices, remoteDevices);
      _currentDevices = remoteDevices;
      _emit(devices: remoteDevices, isConnected: true);
    } catch (e) {
      _emit(devices: localDevices, isConnected: false);
    }
  }

  void _emit({
    required List<Device> devices,
    required bool isConnected,
    Object? error,
  }) {
    if (!_controller.isClosed) {
      _controller.add(
        DevicesSyncState(
          devices: devices,
          isConnected: isConnected,
          error: error,
        ),
      );
    }
  }
}
