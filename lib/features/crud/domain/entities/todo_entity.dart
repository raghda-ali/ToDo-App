class TodoField {
  static const createdTime = 'createdTime';
}

class TodoEntity {
  DateTime createdTime;
  String title;
  String id;
  String description;
  String? userId;

  TodoEntity({
    required this.createdTime,
    required this.title,
    required this.description,
    required this.id,
    this.userId,
  });
}