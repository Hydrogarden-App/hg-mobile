import "package:flutter/material.dart" hide ConnectionState;
import "package:flutter_bloc/flutter_bloc.dart";

import "package:hydrogarden_mobile/app/app.dart";
import "package:hydrogarden_mobile/app/l10n/l10n.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";
import "package:hydrogarden_mobile/presentation/circuit_list/circuit_list_page.dart";
import "package:hydrogarden_mobile/presentation/common/extensions/snack_bar_extension.dart";
import "package:hydrogarden_mobile/presentation/common/widgets/card_button.dart";
import "package:hydrogarden_mobile/presentation/common/widgets/custom_app_bar.dart";
import "package:hydrogarden_mobile/presentation/connection/bloc/connection_bloc.dart";
import "package:hydrogarden_mobile/presentation/device_info/bloc/device_info_bloc.dart";
import "package:hydrogarden_mobile/presentation/device_info/widgets/on_off_info_section.dart";
import "package:hydrogarden_mobile/presentation/logs/logs_page.dart";

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
              final device = state.device!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      device.name,
                      style: context.textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: AppPaddings.medium),
                  if (!state.isLoading)
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: AppPaddings.medium,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CardButton(
                            title: context.l10n.device_info_circuit_info,
                            icon: Icons.chevron_right,
                            onTap: () {
                              context.router.push(CircuitListPage.route);
                            },
                          ),
                          CardButton(
                            title: context.l10n.device_info_watering_schedule,
                            icon: Icons.chevron_right,
                            onTap: () {},
                          ),
                          CardButton(
                            title: context.l10n.device_info_see_logs,
                            icon: Icons.chevron_right,
                            onTap: () {
                              context.router.push(LogsPage.route);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
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
