part of "circuit_list_bloc.dart";

class CircuitListState extends Equatable {
  final bool isLoading;
  final Device? device;
  final String? error;

  const CircuitListState({this.isLoading = false, this.error, this.device});

  CircuitListState copyWith({
    bool? isLoading,
    List<Circuit>? circuits,
    String? error,
    Device? device,
  }) {
    return CircuitListState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      device: device,
    );
  }

  @override
  List<Object?> get props => [isLoading, device, error];
}
