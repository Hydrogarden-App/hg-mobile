part of "device_info_bloc.dart";

class DeviceInfoState extends Equatable {
  final bool isLoading;
  final Device? device;
  final String? error;

  const DeviceInfoState({this.isLoading = false, this.device, this.error});

  DeviceInfoState copyWith({bool? isLoading, Device? device, String? error}) {
    return DeviceInfoState(
      isLoading: isLoading ?? this.isLoading,
      device: device ?? this.device,
      error: error, // You might want to clear this sometimes manually
    );
  }

  @override
  List<Object?> get props => [isLoading, device, error];
}
