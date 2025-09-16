import "package:flutter/material.dart" hide ConnectionState;
import "package:flutter_bloc/flutter_bloc.dart";

import "package:hydrogarden_mobile/app/l10n/l10n.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";

import "package:hydrogarden_mobile/presentation/common/extensions/edit_modal_extension.dart";
import "package:hydrogarden_mobile/presentation/common/extensions/snack_bar_extension.dart";
import "package:hydrogarden_mobile/presentation/common/widgets/app_frame.dart";
import "package:hydrogarden_mobile/presentation/connection/bloc/connection_bloc.dart";
import "package:hydrogarden_mobile/presentation/device_info/bloc/device_info_bloc.dart";
import "package:hydrogarden_mobile/presentation/device_info/widgets/action_cards.dart";
import "package:hydrogarden_mobile/presentation/device_info/widgets/on_off_info_section.dart";

class DeviceInfoView extends StatelessWidget {
  final int deviceId;

  const DeviceInfoView(this.deviceId, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DeviceInfoBloc, DeviceInfoState, (bool, String)>(
      selector: (state) => (state.device == null, state.device?.name ?? ""),
      builder: (context, pair) {
        return AppFrame(
          isLoading: pair.$1,
          title: pair.$2,
          onTitlePressed: () {
            context.showEditableTextDialog(
              placeholder: pair.$2,
              titleText: context.l10n.device_info_change_device_name,
              onSubmitted: (newName) {
                if (newName.isNotEmpty && newName != pair.$2) {
                  context.read<DeviceInfoBloc>().add(
                    DeviceInfoRenameRequested(deviceId, newName),
                  );
                }
              },
            );
          },
          children: [
            BlocConsumer<DeviceInfoBloc, DeviceInfoState>(
              builder: (context, state) {
                if (state.device != null) {
                  final device = state.device!;
                  if (!state.isLoading) {
                    return BlocBuilder<ConnectionBloc, ConnectionState>(
                      builder: (context, state) {
                        if (state.networkStatus == NetworkStatus.connected &&
                            state.serverStatus == ServerStatus.connected) {
                          return OnOffInfoSection(device: device);
                        }
                        return SizedBox.shrink();
                      },
                    );
                  }
                }
                return SizedBox(
                  height: DeviceInfoViewConfig.onOffSectionPlaceholderHeight,
                );
              },
              listenWhen: (previous, current) => !previous.isLoading,
              listener: (context, state) {
                if (state.error != null) {
                  context.showErrorSnackBar(state.error!);
                }
              },
            ),
            SizedBox(height: AppPaddings.large),
            Expanded(
              child: SingleChildScrollView(
                child: ActionCards(deviceId: deviceId),
              ),
            ),
          ],
        );
      },
    );
  }
}
