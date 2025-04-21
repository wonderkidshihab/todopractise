// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class Todo {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isCompleted;
  final DateTime? completedAt;

  const Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.isCompleted,
    this.completedAt,
  });
}
