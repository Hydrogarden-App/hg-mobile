import "package:freezed_annotation/freezed_annotation.dart";

part "circuit.freezed.dart";
part "circuit.g.dart";

@freezed
class Circuit with _$Circuit {
  const factory Circuit({
    required int id,
    required String name,
    required bool state,
    required bool desiredState,
  }) = _Circuit;

  factory Circuit.fromJson(Map<String, dynamic> json) =>
      _$CircuitFromJson(json);
}
