import "package:flutter/material.dart" hide ConnectionState;
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hydrogarden_mobile/app/app.dart";
import "package:hydrogarden_mobile/app/l10n/l10n.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";
import "package:hydrogarden_mobile/presentation/common/widgets/card_button.dart";
import "package:hydrogarden_mobile/presentation/common/widgets/custom_app_bar.dart";
import "package:hydrogarden_mobile/presentation/connection/bloc/connection_bloc.dart";
import "package:hydrogarden_mobile/presentation/device_info/device_info_page.dart";
import "package:hydrogarden_mobile/presentation/home/bloc/home_bloc.dart";

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      appBar: CustomAppBar(hasBackButton: false),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(context.l10n.home_title, style: context.textTheme.titleLarge),
            SizedBox(height: AppPaddings.medium),
            Text(
              context.l10n.home_subtitle,
              style: context.textTheme.titleMedium,
            ),
            BlocBuilder<ConnectionBloc, ConnectionState>(
              builder: (context, state) {
                if (state.connectionStatus == ConnectionStatus.disconnected) {
                  return Text("Please turn on wifi");
                } else if (state.serverStatus == ServerStatus.disconnected) {
                  return Text("Can't conenct to server. not your fault");
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            SizedBox(height: AppPaddings.large),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state.devices != null) {
                    return ListView.builder(
                      itemCount: state.devices!.length,
                      itemBuilder: (context, index) {
                        final device = state.devices![index];
                        return CardButton(
                          title: device.name,
                          icon: Icons.chevron_right,
                          onTap: () {
                            context.router.push(DeviceInfoPage.route);
                          },
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
        ),
      ),
    );
  }
}
