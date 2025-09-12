import "package:flutter/material.dart";
import "package:hydrogarden_mobile/app/l10n/l10n.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(context.l10n.circuit_list_title),
            SizedBox(height: AppPaddings.medium),
            Expanded(
              child: Padding(
                padding: EdgeInsetsGeometry.all(AppPaddings.large),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [CircuitCard()],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
