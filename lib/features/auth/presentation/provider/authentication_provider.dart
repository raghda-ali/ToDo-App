import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/features/auth/domain/entities/user_entity.dart';
import 'package:todo_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:todo_app/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:todo_app/features/auth/domain/use_cases/register_use_case.dart';

class AuthenticationProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;

  bool isLoading = false;
  UserEntity? currentUser;
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();

  AuthenticationProvider({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
  });

  Future<String?> login(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();
      currentUser = await loginUseCase(email, password);
      isLoading = false;
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      if (kDebugMode) {
        print('FirebaseAuthException: ${e.code} - ${e.message}');
      }
      return e.message ?? 'Login failed';
    } catch (e) {
      isLoading = false;
      notifyListeners();
      if (kDebugMode) {
        print('Unexpected error during login: $e');
      }
      return 'Login failed';
    }
  }

  Future<String?> register(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();
      currentUser = await registerUseCase(email, password);

      isLoading = false;
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      if (kDebugMode) {
        print('FirebaseAuthException: ${e.code} - ${e.message}');
      }
      return e.message ?? 'Signup failed';
    } catch (e) {
      isLoading = false;
      notifyListeners();
      if (kDebugMode) {
        print('Unexpected error during registration: $e');
      }
      return 'Signup failed';
    }
  }

  Future<void> logout() async {
    await logoutUseCase();
    notifyListeners();
  }
}
