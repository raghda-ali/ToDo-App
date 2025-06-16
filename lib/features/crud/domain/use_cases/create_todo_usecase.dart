import 'package:todo_app/features/crud/domain/entities/todo_entity.dart';
import 'package:todo_app/features/crud/domain/repository/todo_repository.dart';

class CreateTodoUseCase {
  final TodoRepository todoRepository;

  CreateTodoUseCase({required this.todoRepository});

  Future<String> call(TodoEntity todo) {
    return todoRepository.createTodo(todo);
  }
}
