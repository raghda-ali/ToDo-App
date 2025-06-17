import 'package:todo_app/features/crud/domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  TodoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.createdTime,
    super.userId,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
    createdTime: json['createdTime'].toDate(),
    title: json['title'],
    description: json['description'],
    id: json['id'],
    userId: json['userId'],
  );

  Map<String, dynamic> toJson() => {
    'createdTime': createdTime.toUtc(),
    'title': title,
    'description': description,
    'id': id,
    'userId': userId,
  };
}
