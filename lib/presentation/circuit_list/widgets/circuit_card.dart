import "package:flutter/material.dart" hide ConnectionState;
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";
import "package:hydrogarden_mobile/presentation/circuit_list/bloc/circuit_list_bloc.dart";
import "package:hydrogarden_mobile/presentation/connection/bloc/connection_bloc.dart";

class CircuitCard extends StatelessWidget {
  const CircuitCard({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SurfaceSizeConfig.heightLarge,
      width: double.infinity,
      margin: const EdgeInsets.all(AppPaddings.small),
      padding: const EdgeInsets.all(AppPaddings.large),
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
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Icon(Icons.more_horiz, size: IconSizeConfig.small),
          ),
          BlocBuilder<CircuitListBloc, CircuitListState>(
            builder: (context, state) {
              if (!state.isLoading && state.device != null) {
                return BlocBuilder<ConnectionBloc, ConnectionState>(
                  builder: (context, state) {
                    if (state.connectionStatus == ConnectionStatus.connected &&
                        state.serverStatus == ServerStatus.connected) {
                      return Positioned(
                        bottom: 5,
                        right: 0,
                        child: Switch(value: false, onChanged: (value) {}),
                      );
                    }
                    return SizedBox.shrink();
                  },
                );
              } else {
                return SizedBox.shrink();
              }
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
      ),
    );
  }
}
