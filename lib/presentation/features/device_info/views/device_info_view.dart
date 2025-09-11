import "package:flutter/material.dart";
import "package:hydrogarden_mobile/app/app.dart";
import "package:hydrogarden_mobile/app/l10n/l10n.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";
import "package:hydrogarden_mobile/presentation/features/circuit_list/circuit_list_page.dart";
import "package:hydrogarden_mobile/presentation/features/common/widgets/card_button.dart";
import "package:hydrogarden_mobile/presentation/features/common/widgets/custom_app_bar.dart";
import "package:hydrogarden_mobile/presentation/features/logs/logs_page.dart";

class DeviceInfoView extends StatelessWidget {
  const DeviceInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TODO: device state
            SizedBox(height: AppPaddings.large),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
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
        ),
      ),
    );
  }
}
