part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
  @override
  List<Object> get props => [];
}

class GetAllTodosEvent extends TodoEvent {
  const GetAllTodosEvent();
}

class AddTodoEvent extends TodoEvent {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isCompleted;
  final DateTime? completedAt;
  const AddTodoEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.isCompleted,
    this.completedAt,
  });

  @override
  List<Object> get props => [id, title, description, createdAt, updatedAt, isCompleted, completedAt ?? DateTime.now()];
}

class UpdateTodoEvent extends TodoEvent {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isCompleted;
  final DateTime? completedAt;
  const UpdateTodoEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.isCompleted,
    this.completedAt,
  });

  @override
  List<Object> get props => [id, title, description, createdAt, updatedAt, isCompleted, completedAt ?? DateTime.now()];
}

class DeleteTodoEvent extends TodoEvent {
  final String id;
  const DeleteTodoEvent({required this.id});
  @override
  List<Object> get props => [id];
}

class GetTodoEvent extends TodoEvent {
  final String id;
  const GetTodoEvent({required this.id});

  @override
  List<Object> get props => [id];
}
