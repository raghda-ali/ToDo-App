import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constants/routers_names.dart';
import 'package:todo_app/features/auth/presentation/pages/login_page.dart';
import 'package:todo_app/features/auth/presentation/provider/authentication_provider.dart';
import 'package:todo_app/features/crud/presentation/widgets/todo_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('To Do App'),
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        actionsPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        actions: [
          GestureDetector(
            onTap: () async {
              await authProvider.logout();
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                if (!context.mounted) return;

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              });
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
      body: TodoListWidget(),
    );
  }
}
