class TodoField {
  static const createdTime = 'createdTime';
}

class TodoEntity {
  DateTime createdTime;
  String title;
  String id;
  String description;
  bool isDone;

  TodoEntity({
    required this.createdTime,
    required this.title,
    required this.description,
    required this.id,
    this.isDone = false,
  });

  static TodoEntity fromJson(Map<String, dynamic> json) => TodoEntity(
    createdTime: json['createdTime'].toDate(),
    title: json['title'],
    description: json['description'],
    id: json['id'],
    isDone: json['isDone'],
  );

  Map<String, dynamic> toJson() => {
    'createdTime': createdTime.toUtc(),
    'title': title,
    'description': description,
    'id': id,
    'isDone': isDone,
  };
}
