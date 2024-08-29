import 'package:d_input/d_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod/models/person_model.dart';
import 'package:learn_riverpod/providers/person_provider.dart';

class PersonPage extends ConsumerWidget {
  const PersonPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Person Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: DInput(
                  controller: nameController,
                  hint: 'Name',
                ),
              ),
              IconButton(
                onPressed: () {
                  ref
                      .read(personNotifierProvider.notifier)
                      .updateName(nameController.text);
                },
                icon: const Icon(Icons.save),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: DInput(
                  controller: ageController,
                  hint: 'Age',
                ),
              ),
              IconButton(
                onPressed: () {
                  ref
                      .read(personNotifierProvider.notifier)
                      .updateAge(int.parse(ageController.text));
                },
                icon: const Icon(Icons.save),
              )
            ],
          ),
          const SizedBox(height: 20),
          Consumer(
            builder: (context, wiRef, child) {
              PersonModel person = wiRef.watch(personNotifierProvider);
              return Text('Name: ${person.name}');
            },
          ),
          Consumer(
            builder: (context, wiRef, child) {
              PersonModel person = wiRef.watch(personNotifierProvider);
              return Text('Age: ${person.age}');
            },
          ),
        ],
      ),
    );
  }
}
