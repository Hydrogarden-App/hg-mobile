part of "home_bloc.dart";

class HomeState extends Equatable {
  final List<Device> devices;

  const HomeState._({this.devices = const []});

  const HomeState.disconnected(List<Device> devices) : this._(devices: devices);

  const HomeState.connected(List<Device> devices) : this._(devices: devices);

  @override
  List<Object?> get props => [devices];
}
