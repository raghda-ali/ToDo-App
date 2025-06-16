import 'package:todo_app/features/crud/domain/entities/todo_entity.dart';
import 'package:todo_app/features/crud/domain/repository/todo_repository.dart';

class UpdateTodoUseCase {
  final TodoRepository todoRepository;

  UpdateTodoUseCase({required this.todoRepository});

  Future<void> call(TodoEntity todo) {
    return todoRepository.updateTodo(todo);
  }
}
