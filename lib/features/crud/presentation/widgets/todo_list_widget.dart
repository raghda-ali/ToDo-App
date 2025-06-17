import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constants/routers_names.dart';
import 'package:todo_app/features/crud/presentation/provider/todos_provider.dart';

class TodoListWidget extends StatefulWidget {
  const TodoListWidget({super.key});

  @override
  State<TodoListWidget> createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final todosProvider = Provider.of<TodosProvider>(context, listen: false);
      todosProvider.loadTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final toDoProvider = Provider.of<TodosProvider>(context);

    switch (toDoProvider.state) {
      case TodosState.loading:
        return const Center(
          child: CircularProgressIndicator(color: Colors.black),
        );
      case TodosState.empty:
        return const Center(
          child: Text('List is Empty', style: TextStyle(fontSize: 17)),
        );
      case TodosState.error:
        return const Center(
          child: Text('Something went wrong. Please try again.'),
        );
      case TodosState.loaded:
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
      case TodosState.initial:
      return const SizedBox();
    }
  }
}
