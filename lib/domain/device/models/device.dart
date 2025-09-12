import "package:freezed_annotation/freezed_annotation.dart";
import "package:hive/hive.dart";
import "package:hydrogarden_mobile/domain/device/models/device_state.dart";
import "package:hydrogarden_mobile/domain/device/models/circuit.dart";

part "device.freezed.dart";
part "device.g.dart";

@freezed
@HiveType(typeId: 0)
class Device with _$Device {
  const factory Device({
    @HiveField(0) required int id,
    @HiveField(1) required String name,
    @HiveField(2) required DeviceState state,
    @HiveField(3) required DeviceState desiredState,
    @HiveField(4) required DateTime lastKeepAliveSendTime,
    @HiveField(5) required DateTime lastHeartbeatReceiveTime,
    @HiveField(6) required List<Circuit> circuits,
  }) = _Device;

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
}
