import 'package:todo_app/features/crud/presentation/provider/todos_provider.dart';
import 'package:todo_app/service_locator.dart';
import 'data/data_sources/todo_remote_data_source.dart';
import 'data/repositories/todo_repository_impl.dart';
import 'domain/repository/todo_repository.dart';
import 'domain/use_cases/create_todo_usecase.dart';
import 'domain/use_cases/delete_todo_usecase.dart';
import 'domain/use_cases/read_todo_usecase.dart';
import 'domain/use_cases/update_todo_usecase.dart';

class CrudeDi {
  final sl = ServiceLocator.getIt;

  Future<void> setup() async {
    sl.registerLazySingleton<TodoRemoteDataSource>(
      () => TodoRemoteDataSource(),
    );

    sl.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(sl()));

    sl.registerLazySingleton(() => CreateTodoUseCase(todoRepository: sl()));
    sl.registerLazySingleton(() => ReadTodosUseCase(todoRepository: sl()));
    sl.registerLazySingleton(() => UpdateTodoUseCase(todoRepository: sl()));
    sl.registerLazySingleton(() => DeleteTodoUseCase(todoRepository: sl()));
    sl.registerLazySingleton<TodosProvider>(
      () => TodosProvider(
        createToDoUseCase: sl(),
        deleteToDoUseCase: sl(),
        readToDoUseCase: sl(),
        updateToDoUseCase: sl(),
        todoRepository: sl(),
      ),
    );
  }
}
