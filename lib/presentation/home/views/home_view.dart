import "package:flutter/material.dart";
import "package:hydrogarden_mobile/app/app.dart";
import "package:hydrogarden_mobile/app/l10n/l10n.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";
import "package:hydrogarden_mobile/presentation/common/widgets/card_button.dart";
import "package:hydrogarden_mobile/presentation/common/widgets/custom_app_bar.dart";
import "package:hydrogarden_mobile/presentation/device_info/device_info_page.dart";

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
            SizedBox(height: AppPaddings.large),
            CardButton(
              title: "title",
              icon: Icons.chevron_right,
              onTap: () {
                context.router.push(DeviceInfoPage.route);
              },
            ),
          ],
        ),
      ),
    );
  }
}
