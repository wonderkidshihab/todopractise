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
  final Todo todo;
  const AddTodoEvent({required this.todo});
}

class UpdateTodoEvent extends TodoEvent {
  final Todo todo;
  const UpdateTodoEvent({required this.todo});
}

class DeleteTodoEvent extends TodoEvent {
  final String id;
  const DeleteTodoEvent({required this.id});
}

class GetTodoEvent extends TodoEvent {
  final String id;
  const GetTodoEvent({required this.id});
}
