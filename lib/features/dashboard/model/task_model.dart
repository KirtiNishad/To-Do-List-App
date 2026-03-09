class TaskModel {
  final String id;
  final String title;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  factory TaskModel.fromJson(String id, Map data) {
    return TaskModel(
      id: id,
      title: data["title"],
      isCompleted: data["isCompleted"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "isCompleted": isCompleted,
    };
  }
}