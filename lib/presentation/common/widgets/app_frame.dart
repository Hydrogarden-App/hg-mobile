import "package:flutter/material.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";
import "package:hydrogarden_mobile/app/theme/ui_config.dart";
import "package:hydrogarden_mobile/presentation/common/widgets/connection_state_widget.dart";
import "package:hydrogarden_mobile/presentation/common/widgets/custom_app_bar.dart";

class AppFrame extends StatelessWidget {
  final bool isLoading;
  final String title;
  final List<Widget> children;
  final bool hasBackButton;
  final String? subtitle;
  final String? serverNotRespondingMessage;
  final void Function()? onSettingsPressed;
  final void Function()? onTitlePressed;

  const AppFrame({
    super.key,
    this.isLoading = false,
    required this.title,
    this.hasBackButton = true,
    this.subtitle,
    this.serverNotRespondingMessage,
    this.onSettingsPressed,
    this.onTitlePressed,
    required this.children,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        hasBackButton: hasBackButton,
        onSettings: onSettingsPressed,
      ),
      backgroundColor: context.colorScheme.primary,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsetsGeometry.all(AppPaddings.large),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: onTitlePressed,
                    child: Text(title, style: context.textTheme.titleLarge),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: AppPaddings.medium),
                    Text(subtitle!, style: context.textTheme.titleMedium),
                  ],
                  SizedBox(height: AppPaddings.medium),
                  ConnectionStateWidget(
                    serverErrorMessage: serverNotRespondingMessage,
                  ),
                  SizedBox(height: AppPaddings.medium),
                  ...children,
                ],
              ),
            ),
    );
  }
}
