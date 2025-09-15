import "package:flutter/material.dart";
import "package:hydrogarden_mobile/app/app.dart";
import "package:hydrogarden_mobile/app/l10n/l10n.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";
import "package:hydrogarden_mobile/presentation/common/widgets/card_button.dart";
import "package:hydrogarden_mobile/presentation/logs/logs_page.dart";

class ActionCards extends StatelessWidget {
  const ActionCards({super.key, required this.onTap});
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppPaddings.medium,
      mainAxisSize: MainAxisSize.min,
      children: [
        CardButton(
          title: context.l10n.device_info_circuit_info,
          icon: Icons.chevron_right,
          onTap: onTap,
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
    );
  }
}
