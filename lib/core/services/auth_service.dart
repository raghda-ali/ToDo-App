import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

enum SignUpStatus { success, emailAlreadyInUse, weakPassword, failure }

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<SignUpStatus> signup({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await Future.delayed(const Duration(seconds: 1));
      return SignUpStatus.success;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return SignUpStatus.weakPassword;
      } else if (e.code == 'email-already-in-use') {
        return SignUpStatus.emailAlreadyInUse;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return SignUpStatus.failure;
    }
    return SignUpStatus.failure;
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await Future.delayed(const Duration(seconds: 1));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return 'No user found for that email.';
      } else if (e.code == 'invalid-credential') {
        return 'Wrong password provided for that user.';
      }
    } catch (e) {
      return 'Unexpected Error';
    }
    return null;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await Future.delayed(const Duration(seconds: 1));
  }
}
