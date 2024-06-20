class TodoModel {
  String? id;
  String? title;
  String? description;

  TodoModel({
    this.id,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map, String id) {
    return TodoModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }
}
