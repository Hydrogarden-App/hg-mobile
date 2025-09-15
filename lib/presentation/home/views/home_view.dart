import "package:flutter/material.dart" hide ConnectionState;
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hydrogarden_mobile/app/l10n/l10n.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";
import "package:hydrogarden_mobile/presentation/common/widgets/app_frame.dart";
import "package:hydrogarden_mobile/presentation/common/widgets/card_button.dart";
import "package:hydrogarden_mobile/presentation/home/bloc/home_bloc.dart";

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.navigateToDevice});

  final void Function(int id) navigateToDevice;
  @override
  Widget build(BuildContext context) {
    return AppFrame(
      title: context.l10n.home_title,
      subtitle: context.l10n.home_subtitle,
      hasBackButton: false,
      children: [
        Expanded(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.devices != null) {
                return ListView.builder(
                  itemCount: state.devices!.length,
                  padding: EdgeInsets.all(AppPaddings.small),
                  itemBuilder: (context, index) {
                    final device = state.devices![index];
                    return Container(
                      margin: EdgeInsets.only(bottom: AppPaddings.medium),
                      child: CardButton(
                        title: device.name,
                        icon: Icons.chevron_right,
                        onTap: () {
                          navigateToDevice(device.id);
                        },
                      ),
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ],
    );
  }
}
