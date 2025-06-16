import 'package:todo_app/features/crud/domain/entities/todo_entity.dart';
import 'package:todo_app/features/crud/domain/repository/todo_repository.dart';

class ReadTodosUseCase {
  final TodoRepository todoRepository;

  ReadTodosUseCase({required this.todoRepository});

  Stream<List<TodoEntity>> call() {
    return todoRepository.readTodos();
  }
}
