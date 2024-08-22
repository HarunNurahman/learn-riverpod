import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod/providers/counter_provider.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: OverflowBar(
        children: [
          FloatingActionButton(
            heroTag: 'Increament',
            onPressed: () =>
                ref.read(counterNotifierProvider.notifier).increment(),
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            heroTag: 'Decreament',
            onPressed: () =>
                ref.read(counterNotifierProvider.notifier).decrement(),
            child: const Icon(Icons.remove),
          )
        ],
      ),
      body: Consumer(
        builder: (context, wiRef, child) {
          int counter = wiRef.watch(counterNotifierProvider);
          return Center(
            child: Text(
              '$counter',
              style: const TextStyle(
                fontSize: 36,
              ),
            ),
          );
        },
      ),
    );
  }
}
