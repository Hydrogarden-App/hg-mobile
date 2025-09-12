import "package:freezed_annotation/freezed_annotation.dart";
import "package:hydrogarden_mobile/domain/device/extensions/device_state_extension.dart";
import "package:hydrogarden_mobile/domain/device/models/circuit.dart";

part "device.freezed.dart";
part "device.g.dart";

@freezed
class Device with _$Device {
  const factory Device({
    required int id,
    required String name,
    required DeviceState state,
    required DeviceState desiredState,
    required DateTime lastKeepAliveSendTime,
    required DateTime lastHeartbeatReceiveTime,
    required List<Circuit> circuits,
  }) = _Device;

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
}
