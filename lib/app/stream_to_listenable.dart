import "dart:async";

import "package:flutter/foundation.dart";

class StreamToListenable extends ChangeNotifier {
  late final StreamSubscription _subscription;

  StreamToListenable(Stream stream) {
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
