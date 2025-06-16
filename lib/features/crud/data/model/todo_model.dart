import 'package:todo_app/features/crud/domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  TodoModel({
    required super.createdTime,
    required super.title,
    required super.id,
    required super.description,
  });

  static TodoModel fromJson(Map<String, dynamic> json) => TodoModel(
    createdTime: json['createdTime'].toDate(),
    title: json['title'],
    description: json['description'],
    id: json['id'],
  );

  @override
  Map<String, dynamic> toJson() => {
    'createdTime': createdTime.toUtc(),
    'title': title,
    'description': description,
    'id': id,
    'isDone': isDone,
  };
}
