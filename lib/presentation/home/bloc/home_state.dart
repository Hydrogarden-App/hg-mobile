part of "home_bloc.dart";

class HomeState extends Equatable {
  final List<Device>? devices;

  const HomeState._({this.devices});

  const HomeState.loading() : this._();

  const HomeState.loaded(List<Device> devices) : this._(devices: devices);

  @override
  List<Object?> get props => [devices];
}
