import 'package:todo_app/features/auth/domain/entities/user_entity.dart';
import 'package:todo_app/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase{
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository,
  });
  Future<UserEntity?> call(String email, String password) {
    return authRepository.login(email, password);
  }
}