import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/features/crud/domain/entities/todo_entity.dart';
import 'package:todo_app/features/crud/domain/repository/todo_repository.dart';
import 'package:todo_app/features/crud/domain/use_cases/create_todo_usecase.dart';
import 'package:todo_app/features/crud/domain/use_cases/delete_todo_usecase.dart';
import 'package:todo_app/features/crud/domain/use_cases/read_todo_usecase.dart';
import 'package:todo_app/features/crud/domain/use_cases/update_todo_usecase.dart';
enum TodosState {
  initial,
  loading,
  loaded,
  empty,
  error,
}

class TodosProvider extends ChangeNotifier {
  final CreateTodoUseCase createToDoUseCase;
  final ReadTodosUseCase readToDoUseCase;
  final UpdateTodoUseCase updateToDoUseCase;
  final DeleteTodoUseCase deleteToDoUseCase;

  List<TodoEntity> _todos = [];
  List<TodoEntity> get todos => _todos;
  final TodoRepository todoRepository;
  TextEditingController addTitleController = TextEditingController();
  TextEditingController addDescriptionController = TextEditingController();
  bool isAddLoading = false;
  bool isEditLoading = false;
  bool hasLoadedOnce = false;
  TodosState _state = TodosState.initial;
  TodosState get state => _state;

  TextEditingController editTitleController = TextEditingController();
  TextEditingController editDescriptionController = TextEditingController();

  TodosProvider({
    required this.createToDoUseCase,
    required this.readToDoUseCase,
    required this.updateToDoUseCase,
    required this.deleteToDoUseCase,
    required this.todoRepository,
  });

  // void loadTodos() {
  //   _todos.clear();
  //   if (isLoading) return;
  //
  //   isLoading = true;
  //   notifyListeners();
  //
  //   todoRepository.readTodos().listen((todos) {
  //     _todos = todos;
  //     isLoading = false;
  //     notifyListeners();
  //   });
  // }
  void loadTodos() {
    _todos.clear();
    if (_state == TodosState.loading) return;

    _state = TodosState.loading;
    notifyListeners();

    todoRepository.readTodos().listen((todos) {
      _todos = todos;
      _state = _todos.isEmpty ? TodosState.empty : TodosState.loaded;
      notifyListeners();
    }, onError: (e) {
      _state = TodosState.error;
      notifyListeners();
    });
  }

  Future<void> addTodo(TodoEntity todo) async {
    isAddLoading = true;
    notifyListeners();

    try {
      await createToDoUseCase(todo);
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      isAddLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateTodo(TodoEntity todo) async {
    isEditLoading = true;
    notifyListeners();
    try {
      await updateToDoUseCase(todo);
    } catch (e) {
      if (kDebugMode) {
        print('Error while updating todo: $e');
      }
    } finally {
      isEditLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteTodo(TodoEntity todo) async {
    await deleteToDoUseCase(todo);
    notifyListeners();
  }
}
