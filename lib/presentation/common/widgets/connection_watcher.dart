import "package:flutter/widgets.dart" hide ConnectionState;
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hydrogarden_mobile/presentation/common/extensions/snack_bar_extension.dart";
import "package:hydrogarden_mobile/presentation/connection/bloc/connection_bloc.dart";

class ConnectionWatcher extends StatelessWidget {
  final Widget child;

  const ConnectionWatcher({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectionBloc, ConnectionState>(
      listenWhen: (previous, state) {
        return previous.networkStatus != state.networkStatus;
      },
      listener: (context, state) {
        context.showInfoSnackBar(
          state.networkStatus == NetworkStatus.connected
              ? "odzyskano połączenie z internetem"
              : " utracono połaczenie z serwerem",
        );
      },
      child: child,
    );
  }
}
