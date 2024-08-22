import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod/models/todo_model.dart';
import 'package:learn_riverpod/providers/todo_provider.dart';

class TodoPage extends ConsumerStatefulWidget {
  const TodoPage({super.key});

  @override
  ConsumerState<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends ConsumerState<TodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  buildAdd() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        title: const Text('Add Todo'),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              label: Text('Title'),
              hintText: 'Enter Title',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: descController,
            decoration: const InputDecoration(
              label: Text('Description'),
              hintText: 'Enter Description',
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref
                  .read(todoNotifierProvider.notifier)
                  .add(titleController.text, descController.text);
              titleController.clear();
              descController.clear();
            },
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }

  buildEdit(TodoModel todo) {
    titleController.text = todo.text!;
    descController.text = todo.desc!;
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        title: const Text('Edit Todo'),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              label: Text('Title'),
              hintText: 'Enter Title',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: descController,
            decoration: const InputDecoration(
              label: Text('Description'),
              hintText: 'Enter Description',
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              TodoModel updateTodo = todo.copyWith(
                text: titleController.text,
                desc: descController.text,
              );
              ref.read(todoNotifierProvider.notifier).edit(updateTodo);
              titleController.clear();
              descController.clear();
            },
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => buildAdd(),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Consumer(
          builder: (context, wiRef, child) {
            List<TodoModel> todos = wiRef.watch(todoNotifierProvider);
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                TodoModel todo = todos[index];
                return ListTile(
                  leading: IconButton.filledTonal(
                    onPressed: () => buildEdit(todo),
                    icon: const Icon(Icons.edit, size: 16),
                  ),
                  title: Text(todo.text!),
                  subtitle: Text(todo.desc!),
                  trailing: IconButton.filledTonal(
                    onPressed: () => ref
                        .read(todoNotifierProvider.notifier)
                        .delete(todo.id!),
                    icon: const Icon(Icons.delete, size: 16),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
