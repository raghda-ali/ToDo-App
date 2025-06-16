import 'package:todo_app/features/auth/presentation/provider/authentication_provider.dart';
import 'package:todo_app/service_locator.dart';

import 'data/data_sources/auth_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/use_cases/login_use_case.dart';
import 'domain/use_cases/logout_use_case.dart';
import 'domain/use_cases/register_use_case.dart';

class AuthDi {
  final sl = ServiceLocator.getIt;

  Future<void> setup() async {
    // Data Source
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(),
    );
    // Repository
    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

    // Use Cases
    sl.registerLazySingleton(() => LoginUseCase(authRepository: sl()));
    sl.registerLazySingleton(() => RegisterUseCase(authRepository: sl()));
    sl.registerLazySingleton(() => LogoutUseCase(authRepository: sl()));

    // Provider

    sl.registerLazySingleton<AuthenticationProvider>(
      () => AuthenticationProvider(
        loginUseCase: sl(),
        registerUseCase: sl(),
        logoutUseCase: sl(),
      ),
    );
  }
}
