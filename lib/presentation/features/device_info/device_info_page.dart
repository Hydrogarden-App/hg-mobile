import "package:flutter/material.dart";
import "package:hydrogarden_mobile/presentation/features/device_info/views/device_info_view.dart";

class DeviceInfoPage extends StatelessWidget {
  const DeviceInfoPage({super.key});

  static const route = "/device_info";

  @override
  Widget build(BuildContext context) {
    return DeviceInfoView();
  }
}
