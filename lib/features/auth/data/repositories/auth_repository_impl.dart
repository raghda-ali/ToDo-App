import 'package:todo_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<UserEntity?> login(String email, String password) {
    return authRemoteDataSource.login(email, password);
  }

  @override
  Future<UserEntity?> register(String email, String password) {
    return authRemoteDataSource.register(email, password);
  }

  @override
  Future<void> logout() {
    return authRemoteDataSource.logout();
  }
}
