import 'package:learn_riverpod/models/todo_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'todo_provider.g.dart';

@Riverpod(keepAlive: true)
class TodoNotifier extends _$TodoNotifier {
  @override
  List<TodoModel> build() => <TodoModel>[];

  add(String title, String body) {
    TodoModel newTodo = TodoModel(
      id: const Uuid().v4(),
      text: title,
      desc: body,
    );

    state = [...state, newTodo];
  }

  edit(TodoModel todo) {
    int index = state.indexWhere((element) => element.id == todo.id);
    state[index] = todo;

    state = [...state];
  }

  delete(String id) {
    state.removeWhere((element) => element.id == id);
    state = [...state];
  }
}
