import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUnixTimeStateProvider =
    StateProvider.autoDispose<CurrentUnixTimeState>((ref) {
  CurrentUnixTimeState state = CurrentUnixTimeState();
  state.loop();
  return state;
});

class CurrentUnixTimeState {
  int currentUnixTime;

  CurrentUnixTimeState()
      : currentUnixTime = DateTime.now().millisecondsSinceEpoch;

  void loop() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateCurrentUnixTime();
    });
  }

  void _updateCurrentUnixTime() {
    currentUnixTime = DateTime.now().millisecondsSinceEpoch;
  }
}
