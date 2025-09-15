import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "package:hydrogarden_mobile/app/l10n/l10n.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";
import "package:hydrogarden_mobile/domain/device/models/circuit.dart";
import "package:hydrogarden_mobile/presentation/circuit_list/bloc/circuit_list_bloc.dart";
import "package:hydrogarden_mobile/presentation/circuit_list/widgets/circuit_card.dart";
import "package:hydrogarden_mobile/presentation/common/extensions/snack_bar_extension.dart";
import "package:hydrogarden_mobile/presentation/common/widgets/app_frame.dart";

class CircuitListView extends StatelessWidget {
  final int deviceId;
  const CircuitListView({super.key, required this.deviceId});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CircuitListBloc, CircuitListState, (bool, String)>(
      selector: (state) => (state.device == null, state.device?.name ?? ""),
      builder: (context, pair) {
        return BlocListener<CircuitListBloc, CircuitListState>(
          listenWhen: (previous, current) =>
              !previous.isLoading && current.error != null,
          listener: (context, state) {
            context.showErrorSnackBar(state.error!);
          },
          child: AppFrame(
            title: context.l10n.circuit_list_title,
            subtitle: pair.$2,
            children: [
              BlocSelector<CircuitListBloc, CircuitListState, List<Circuit>>(
                selector: (state) => state.device?.circuits ?? [],
                builder: (context, circuits) {
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(AppPaddings.small),
                      shrinkWrap: true,
                      itemCount: circuits.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: AppPaddings.medium),
                          child: CircuitCard(
                            deviceId: deviceId,
                            circuit: circuits[index],
                            onToggle: (value) {
                              context.read<CircuitListBloc>().add(
                                value
                                    ? CircuitListTurnOnRequested(
                                        deviceId,
                                        circuits[index].id,
                                      )
                                    : CircuitListTurnOffRequested(
                                        deviceId,
                                        circuits[index].id,
                                      ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
