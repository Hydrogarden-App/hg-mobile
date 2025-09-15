import "package:flutter/material.dart";
import "package:hydrogarden_mobile/app/l10n/l10n.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";

enum CircuitCardAction { rename, seeSchedule, addSingleWatering }

class CardMenuButton extends StatelessWidget {
  final void Function(CircuitCardAction value)? onSelected;

  const CardMenuButton({super.key, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_horiz, size: IconSizeConfig.medium),
      itemBuilder: (BuildContext context) =>
          <PopupMenuEntry<CircuitCardAction>>[
            PopupMenuItem<CircuitCardAction>(
              value: CircuitCardAction.rename,
              child: Text(
                context.l10n.circuit_list_card_action_rename,
                style: context.textTheme.bodyMedium,
              ),
            ),
            PopupMenuDivider(
              thickness: 0.0,
              indent: AppPaddings.enormous,
              endIndent: AppPaddings.enormous,
            ),
            PopupMenuItem<CircuitCardAction>(
              value: CircuitCardAction.seeSchedule,
              child: Text(
                context.l10n.circuit_list_card_action_see_schedule,
                style: context.textTheme.bodyMedium,
              ),
            ),
            PopupMenuDivider(
              thickness: 0.0,
              indent: AppPaddings.enormous,
              endIndent: AppPaddings.enormous,
            ),
            PopupMenuItem<CircuitCardAction>(
              value: CircuitCardAction.addSingleWatering,
              child: Text(
                context.l10n.circuit_list_card_action_add_single_watering,
                style: context.textTheme.bodyMedium,
              ),
            ),
          ],
      onSelected: onSelected,
    );
  }
}
