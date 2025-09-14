// part of "device_info_bloc.dart";

// class DeviceInfoState extends Equatable {
//   final Device? device;
//   final String? error;

//   const DeviceInfoState._({this.device, this.error});

//   const DeviceInfoState.loading() : this._();

//   const DeviceInfoState.error(String error) : this._(error: error);

//   const DeviceInfoState.loaded(Device device) : this._(device: device);

//   @override
//   List<Object?> get props => [device, error];
// }

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
