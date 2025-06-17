import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constants/routers_names.dart';
import 'package:todo_app/features/crud/presentation/provider/todos_provider.dart';
import 'package:todo_app/features/auth/presentation/provider/authentication_provider.dart';
import 'package:todo_app/features/crud/presentation/widgets/todo_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final toDoProvider = Provider.of<TodosProvider>(context);
    final authProvider = Provider.of<AuthenticationProvider>(context);
    final todos = toDoProvider.todos;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('To Do App'),
        backgroundColor: Colors.white,
        elevation:1,
        automaticallyImplyLeading: false,
        actionsPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        actions: [
          GestureDetector(
            onTap: () async {
              authProvider.logout();
              if (!context.mounted) return;

              Navigator.of(context).pushNamedAndRemoveUntil(
                RoutersNames.loginPage,
                (route) => false,
              );
            },
            child: Text('Logout', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutersNames.addToDoPage);
        },
        child: const Icon(Icons.add),
      ),
      body: TodoListWidget(todos: todos),
    );
  }
}
