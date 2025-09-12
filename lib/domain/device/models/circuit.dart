import "package:freezed_annotation/freezed_annotation.dart";
import "package:hive/hive.dart";

part "circuit.freezed.dart";
part "circuit.g.dart";

@freezed
@HiveType(typeId: 1)
class Circuit with _$Circuit {
  const factory Circuit({
    @HiveField(0) required int id,
    @HiveField(1) required String name,
    @HiveField(2) required bool state,
    @HiveField(3) required bool desiredState,
  }) = _Circuit;

  factory Circuit.fromJson(Map<String, dynamic> json) =>
      _$CircuitFromJson(json);
}
