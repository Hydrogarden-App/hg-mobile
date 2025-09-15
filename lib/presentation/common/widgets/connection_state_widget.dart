import "package:flutter/material.dart" hide ConnectionState;
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hydrogarden_mobile/app/l10n/l10n.dart";
import "package:hydrogarden_mobile/app/theme/app_theme.dart";
import "package:hydrogarden_mobile/presentation/connection/bloc/connection_bloc.dart";

class ConnectionStateWidget extends StatelessWidget {
  final String? serverErrorMessage;

  const ConnectionStateWidget({super.key, this.serverErrorMessage});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionBloc, ConnectionState>(
      builder: (context, state) {
        if (state.connectionStatus == ConnectionStatus.disconnected) {
          return Text(
            context.l10n.common_error_network,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.error,
            ),
          );
        } else if (state.serverStatus == ServerStatus.disconnected) {
          return Text(
            serverErrorMessage != null
                ? serverErrorMessage!
                : context.l10n.common_error_server,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.error,
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
