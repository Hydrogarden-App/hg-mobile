import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hydrogarden_mobile/app/l10n/l10n.dart";
import "package:hydrogarden_mobile/presentation/common/widgets/app_frame.dart";
import "package:hydrogarden_mobile/presentation/device_info/bloc/device_info_bloc.dart";

class LogsView extends StatelessWidget {
  const LogsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DeviceInfoBloc, DeviceInfoState, String>(
      selector: (state) => state.device?.name ?? "",
      builder: (context, name) {
        return AppFrame(
          title: context.l10n.logs_title,
          subtitle: name,
          children: [],
        );
      },
    );
  }
}
