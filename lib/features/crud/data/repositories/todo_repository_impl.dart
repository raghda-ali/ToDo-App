import 'package:todo_app/features/crud/data/data_sources/todo_remote_data_source.dart';
import 'package:todo_app/features/crud/data/model/todo_model.dart';
import 'package:todo_app/features/crud/domain/entities/todo_entity.dart';
import 'package:todo_app/features/crud/domain/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource todoRemoteDataSource;

  TodoRepositoryImpl(this.todoRemoteDataSource);

  @override
  Future<String> createTodo(TodoEntity todo) {
    return todoRemoteDataSource.createTodo(
      TodoModel(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        createdTime: todo.createdTime,
        userId: todo.userId,
      ),
    );
  }

  @override
  Stream<List<TodoEntity>> readTodos() {
    return todoRemoteDataSource.readTodos();
  }

  @override
  Future<void> updateTodo(TodoEntity todo) {
    return todoRemoteDataSource.updateTodo(
      TodoModel(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        createdTime: todo.createdTime,
        userId: todo.userId,
      ),
    );
  }

  @override
  Future<void> deleteTodo(TodoEntity todo) {
    return todoRemoteDataSource.deleteTodo(
      TodoModel(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        createdTime: todo.createdTime,
        userId: todo.userId,
      ),
    );
  }
}
