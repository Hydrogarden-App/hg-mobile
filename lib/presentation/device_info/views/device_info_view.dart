import "package:flutter/material.dart" hide ConnectionState;
import "package:flutter_bloc/flutter_bloc.dart";

import "package:hydrogarden_mobile/app/l10n/l10n.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";
import "package:hydrogarden_mobile/presentation/common/extensions/edit_modal_extension.dart";
import "package:hydrogarden_mobile/presentation/common/extensions/snack_bar_extension.dart";
import "package:hydrogarden_mobile/presentation/common/widgets/custom_app_bar.dart";
import "package:hydrogarden_mobile/presentation/connection/bloc/connection_bloc.dart";
import "package:hydrogarden_mobile/presentation/device_info/bloc/device_info_bloc.dart";
import "package:hydrogarden_mobile/presentation/device_info/widgets/action_cards.dart";
import "package:hydrogarden_mobile/presentation/device_info/widgets/on_off_info_section.dart";

class DeviceInfoView extends StatelessWidget {
  final int deviceId;
  const DeviceInfoView(this.deviceId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      appBar: CustomAppBar(),
      body: Center(
        child: BlocConsumer<DeviceInfoBloc, DeviceInfoState>(
          builder: (context, state) {
            if (state.device != null) {
              final isLoading = state.isLoading;
              final device = state.device!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocBuilder<ConnectionBloc, ConnectionState>(
                    builder: (context, state) {
                      return TextButton(
                        onPressed: () {
                          if (!isLoading &&
                              state.connectionStatus ==
                                  ConnectionStatus.connected &&
                              state.serverStatus == ServerStatus.connected) {
                            context.showEditableTextDialog(
                              placeholder: device.name,
                              titleText:
                                  context.l10n.device_info_change_device_name,
                              onSubmitted: (newName) {
                                if (newName.isNotEmpty &&
                                    newName != device.name) {
                                  context.read<DeviceInfoBloc>().add(
                                    DeviceInfoRenameRequested(
                                      device.id,
                                      newName,
                                    ),
                                  );
                                }
                              },
                            );
                          } else {
                            context.showErrorSnackBar(
                              context.l10n.device_info_cant_rename,
                            );
                          }
                        },
                        child: Text(
                          device.name,
                          style: context.textTheme.titleLarge,
                        ),
                      );
                    },
                  ),

                  SizedBox(height: AppPaddings.medium),
                  if (!isLoading)
                    BlocBuilder<ConnectionBloc, ConnectionState>(
                      builder: (context, state) {
                        if (state.connectionStatus ==
                            ConnectionStatus.disconnected) {
                          return Text(
                            context.l10n.home_error_network,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.error,
                            ),
                          );
                        } else if (state.serverStatus ==
                            ServerStatus.disconnected) {
                          return Text(
                            context.l10n.home_error_server,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.error,
                            ),
                          );
                        } else {
                          return OnOffInfoSection(device: device);
                        }
                      },
                    ),

                  SizedBox(height: AppPaddings.large),
                  Expanded(child: SingleChildScrollView(child: ActionCards())),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
          listenWhen: (previous, current) => !previous.isLoading,
          listener: (context, state) {
            if (state.error != null) {
              context.showErrorSnackBar(state.error!);
            }
          },
        ),
      ),
    );
  }
}
