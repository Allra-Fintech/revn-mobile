// counter notifier

import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterControllerProvider = NotifierProvider<CounterController, int>(
  () => CounterController(),
);

class CounterController extends Notifier<int> {
  @override
  int build() => 0;

  void increment() {
    state++;
  }

  void decrement() {
    if (state <= 0) return;
    state--;
  }

  void reset() {
    state = 0;
  }
}
