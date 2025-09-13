import "package:flutter/material.dart";
import "package:hive/hive.dart";
import "package:hydrogarden_mobile/domain/device/models/circuit.dart";
import "package:hydrogarden_mobile/domain/device/models/device.dart";
import "package:hydrogarden_mobile/domain/device/models/device_state.dart";
import "package:path_provider/path_provider.dart";

Future<void> setupHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  Hive.registerAdapter<Device>(DeviceAdapter());
  Hive.registerAdapter<Circuit>(CircuitAdapter());
  Hive.registerAdapter<DeviceState>(DeviceStateAdapter());
}
