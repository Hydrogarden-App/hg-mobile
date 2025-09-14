import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hydrogarden_mobile/app/l10n/l10n.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";
import "package:hydrogarden_mobile/domain/device/models/device.dart";
import "package:hydrogarden_mobile/domain/device/models/device_state.dart";
import "package:hydrogarden_mobile/presentation/device_info/bloc/device_info_bloc.dart";

class OnOffInfoSection extends StatelessWidget {
  const OnOffInfoSection({super.key, required this.device});

  final Device device;

  @override
  Widget build(BuildContext context) {
    final isOn = device.state == DeviceState.alive;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "${context.l10n.device_info_device_state}: "
          "${isOn ? context.l10n.device_info_on : context.l10n.device_info_off}.",
        ),
        const SizedBox(height: 8),
        IconButton(
          onPressed: () {
            context.read<DeviceInfoBloc>().add(
              isOn
                  ? DeviceInfoTurnOffRequested(device.id)
                  : DeviceInfoTurnOnRequested(device.id),
            );
          },
          icon: Icon(
            Icons.settings_power,
            size: 48,
            color: isOn
                ? context.colorScheme.secondary
                : context.colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }
}
