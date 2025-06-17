import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constants/routers_names.dart';
import 'package:todo_app/features/crud/presentation/provider/todos_provider.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final toDoProvider = Provider.of<TodosProvider>(context);
    if (toDoProvider.isLoading == true) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.black),
      );
    }

    if (toDoProvider.todos.isEmpty) {
      return const Center(
        child: Text('List is Empty', style: TextStyle(fontSize: 17)),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: toDoProvider.todos.length,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final todo = toDoProvider.todos[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: ListTile(
            title: Text(todo.title),
            subtitle: Text(todo.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RoutersNames.editToDoPage,
                      arguments: todo,
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    toDoProvider.deleteTodo(todo);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
