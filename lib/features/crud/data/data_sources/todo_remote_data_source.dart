import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/features/crud/data/model/todo_model.dart';

class TodoRemoteDataSource {
  final firebaseFireStore = FirebaseFirestore.instance.collection('todo');

  Future<String> createTodo(TodoModel todo) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    final doc = firebaseFireStore.doc();
    todo.id = doc.id;
    todo.userId = user.uid;

    await doc.set(todo.toJson());
    return doc.id;
  }

  Stream<List<TodoModel>> readTodos() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      return const Stream.empty();
    }

    return firebaseFireStore.where('userId', isEqualTo: userId).snapshots().map(
      (snapshot) {
        return snapshot.docs
            .map((doc) => TodoModel.fromJson(doc.data()))
            .toList();
      },
    );
  }

  Future<void> updateTodo(TodoModel todo) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");
    todo.userId = user.uid;
    await firebaseFireStore.doc(todo.id).update(todo.toJson());
  }

  Future<void> deleteTodo(TodoModel todo) async {
    await firebaseFireStore.doc(todo.id).delete();
  }
}
