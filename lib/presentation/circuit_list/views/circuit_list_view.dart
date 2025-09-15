import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hydrogarden_mobile/app/l10n/l10n.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";
import "package:hydrogarden_mobile/presentation/circuit_list/bloc/circuit_list_bloc.dart";
import "package:hydrogarden_mobile/presentation/circuit_list/widgets/circuit_card.dart";
import "package:hydrogarden_mobile/presentation/common/widgets/custom_app_bar.dart";

class CircuitListView extends StatelessWidget {
  const CircuitListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      appBar: CustomAppBar(),
      body: Center(
        child: BlocConsumer<CircuitListBloc, CircuitListState>(
          builder: (context, state) {
            if (state.device != null) {
              final device = state.device!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    context.l10n.circuit_list_title,
                    style: context.textTheme.titleLarge,
                  ),
                  SizedBox(height: AppPaddings.medium),
                  Text(device.name, style: context.textTheme.titleMedium),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(AppPaddings.large),
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: device.circuits.length,
                          itemBuilder: (context, index) {
                            return CircuitCard(
                              id: index,
                              name: device.circuits[index].name,
                              onToggle: (value) {
                                context.read<CircuitListBloc>().add(
                                  value
                                      ? CircuitListTurnOnRequested(
                                          device.id,
                                          device.circuits[index].id,
                                        )
                                      : CircuitListTurnOffRequested(
                                          device.id,
                                          device.circuits[index].id,
                                        ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
