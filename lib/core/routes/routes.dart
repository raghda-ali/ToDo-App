import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/routers_names.dart';
import 'package:todo_app/features/crud/presentation/pages/home_page.dart';
import 'package:todo_app/features/auth/presentation/pages/login_page.dart';
import 'package:todo_app/features/auth/presentation/pages/register_page.dart';
import 'package:todo_app/features/crud/domain/entities/todo_entity.dart';
import 'package:todo_app/features/crud/presentation/pages/add_todo_page.dart';
import 'package:todo_app/features/crud/presentation/pages/edit_todo_page.dart';

class AppRouters {
  AppRouters();

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutersNames.homePage:
        return MaterialPageRoute(
          builder: (context) => HomePage(),
        );
      case RoutersNames.loginPage:
        return MaterialPageRoute(
          builder: (_) =>  LoginPage(),
        );
      case RoutersNames.registerPage:
        return MaterialPageRoute(
          builder: (_) =>  RegisterPage(),
        );
      case RoutersNames.addToDoPage:
        return MaterialPageRoute(
          builder: (_) =>  AddTodoPage(),
        );
      case RoutersNames.editToDoPage:
        final todo = settings.arguments as TodoEntity;
        return MaterialPageRoute(
          builder: (_) =>  EditTodoPage(
            todo: todo,
          ),
        );
    }
    return null;
  }
}
