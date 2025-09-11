import "package:flutter/material.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";

class CardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function() onTap;

  const CardButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: SurfaceSizeConfig.heightLarge,
        margin: const EdgeInsets.all(AppPaddings.medium),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: context.textTheme.titleMedium),
            Icon(icon),
          ],
        ),
      ),
    );
  }
}
