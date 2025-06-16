import 'package:todo_app/features/auth/domain/entities/user_entity.dart';

import '../repositories/auth_repository.dart';

class RegisterUseCase{
  final AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});
  Future<UserEntity?> call(String email, String password) {
    return authRepository.register(email, password);
  }
}