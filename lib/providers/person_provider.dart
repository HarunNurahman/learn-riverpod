import 'package:learn_riverpod/models/person_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'person_provider.g.dart';

@riverpod
class PersonNotifier extends _$PersonNotifier {
  @override
  PersonModel build() => PersonModel('name', 0);

  updateName(String n) => state = state.copyWith(name: n);
  updateAge(int n) => state = state.copyWith(age: n);
}
