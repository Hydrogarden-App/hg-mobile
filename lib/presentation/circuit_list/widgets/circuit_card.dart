import "package:flutter/material.dart" hide ConnectionState;
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_switch/flutter_switch.dart";
import "package:hydrogarden_mobile/app/l10n/l10n.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";
import "package:hydrogarden_mobile/presentation/circuit_list/bloc/circuit_list_bloc.dart";
import "package:hydrogarden_mobile/presentation/circuit_list/widgets/card_menu_button.dart";
import "package:hydrogarden_mobile/presentation/common/extensions/edit_modal_extension.dart";
import "package:hydrogarden_mobile/presentation/connection/bloc/connection_bloc.dart";

class CircuitCard extends StatelessWidget {
  const CircuitCard({
    super.key,
    required this.id,
    required this.name,
    required this.onToggle,
  });

  final String name;
  final int id;
  final void Function(bool) onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SurfaceSizeConfig.heightLarge,
      width: double.infinity,
      margin: const EdgeInsets.all(AppPaddings.small),
      padding: const EdgeInsets.symmetric(
        vertical: AppPaddings.medium,
        horizontal: AppPaddings.large,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.circular(CornerRoundingConfig.medium),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow,
            blurRadius: BlurConfig.radius,
            spreadRadius: BlurConfig.spread,
          ),
        ],
      ),
      child: BlocBuilder<CircuitListBloc, CircuitListState>(
        builder: (context, state) {
          if (!state.isLoading && state.device != null) {
            final device = state.device!;
            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: CardMenuButton(
                    onSelected: (value) {
                      switch (value) {
                        case CircuitCardAction.rename:
                          context.showEditableTextDialog(
                            placeholder: device.circuits[id].name,
                            titleText:
                                context.l10n.circuit_list_card_action_rename,
                            onSubmitted: (name) {
                              context.read<CircuitListBloc>().add(
                                CircuitListRenameRequested(
                                  device.id,
                                  device.circuits[id].id,
                                  name,
                                ),
                              );
                            },
                          );
                        default:
                          () {};
                      }
                    },
                  ),
                ),

                BlocBuilder<ConnectionBloc, ConnectionState>(
                  builder: (context, state) {
                    if (state.connectionStatus == ConnectionStatus.connected &&
                        state.serverStatus == ServerStatus.connected) {
                      return Positioned(
                        bottom: 5,
                        right: 0,
                        child: FlutterSwitch(
                          height: 30,
                          padding: 1,
                          toggleSize: 28,
                          switchBorder: Border.all(
                            color: context.colorScheme.onPrimary,
                          ),
                          value: device.circuits[id].state,
                          onToggle: onToggle,
                          activeColor: context.colorScheme.secondary,
                          inactiveColor: context.colorScheme.primary,
                          toggleColor: context.colorScheme.onPrimary,
                        ),
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: context.textTheme.titleMedium),
                    const Spacer(),
                    Text(
                      "Następne podlewanie: śr, 3:12",
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
