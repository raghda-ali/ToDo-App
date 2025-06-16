import 'package:todo_app/features/crud/domain/entities/todo_entity.dart';

abstract class TodoRepository {
  Future<String> createTodo(TodoEntity todo);
  Stream<List<TodoEntity>> readTodos();
  Future<void> updateTodo(TodoEntity todo);
  Future<void> deleteTodo(TodoEntity todo);
}
