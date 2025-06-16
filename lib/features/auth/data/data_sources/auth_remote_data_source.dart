import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_entity.dart';

class AuthRemoteDataSource {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserEntity?> login(String email, String password) async {
    final result = await auth.signInWithEmailAndPassword(email: email, password: password);
    final user = result.user;
    if (user != null) {
      return UserEntity(uid: user.uid, email: user.email ?? '');
    }
    return null;
  }

  Future<UserEntity?> register(String email, String password) async {
    final result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    final user = result.user;
    if (user != null) {
      return UserEntity(uid: user.uid, email: user.email ?? '');
    }
    return null;
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
