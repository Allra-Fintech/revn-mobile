import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/counter_controller.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterControllerProvider);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          Center(child: Text('$counter')),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              ElevatedButton(
                onPressed: () =>
                    ref.read(counterControllerProvider.notifier).increment(),
                child: Text('Increment'),
              ),
              ElevatedButton(
                onPressed: () =>
                    ref.read(counterControllerProvider.notifier).decrement(),
                child: Text('Decrement'),
              ),
              ElevatedButton(
                onPressed: () =>
                    ref.read(counterControllerProvider.notifier).reset(),
                child: Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
