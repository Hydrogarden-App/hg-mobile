part of "device_sync_manager.dart";

class DevicesSyncState {
  final List<Device> devices;
  final bool isConnected;
  final Object? error;

  const DevicesSyncState({
    required this.devices,
    required this.isConnected,
    this.error,
  });

  DevicesSyncState copyWith({
    List<Device>? devices,
    bool? isConnected,
    Object? error,
  }) {
    return DevicesSyncState(
      devices: devices ?? this.devices,
      isConnected: isConnected ?? this.isConnected,
      error: error ?? this.error,
    );
  }
}
