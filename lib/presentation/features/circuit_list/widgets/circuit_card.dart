import "package:flutter/material.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";

class CircuitCard extends StatelessWidget {
  const CircuitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SurfaceSizeConfig.heightLarge,
      width: double.infinity,
      margin: const EdgeInsets.all(AppPaddings.small),
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
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Icon(Icons.more_horiz, size: IconSizeConfig.small),
          ),
          Positioned(
            bottom: 5,
            right: 0,
            child: Switch(value: false, onChanged: (value) {}),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Rzeżucha", style: context.textTheme.titleMedium),
              const Spacer(),
              Text(
                "Następne podlewanie: śr, 3:12",
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
