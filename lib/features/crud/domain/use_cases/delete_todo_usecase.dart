import 'package:todo_app/features/crud/domain/repository/todo_repository.dart';

import '../entities/todo_entity.dart';

class DeleteTodoUseCase {
  final TodoRepository todoRepository;

  DeleteTodoUseCase({required this.todoRepository});

  Future<void> call(TodoEntity todo) {
    return todoRepository.deleteTodo(todo);
  }
}
