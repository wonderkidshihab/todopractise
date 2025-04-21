part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;

  const TodoLoaded({required this.todos});

  @override
  List<Object> get props => [todos];
}

class TodoError extends TodoState {
  final String message;

  const TodoError({required this.message});

  @override
  List<Object> get props => [message];
}

class TodoEmpty extends TodoState {}

class TodoDeleted extends TodoState {
  final String message;

  const TodoDeleted({required this.message});

  @override
  List<Object> get props => [message];
}

class TodoUpdated extends TodoState {
  final String message;

  const TodoUpdated({required this.message});

  @override
  List<Object> get props => [message];
}

class TodoAdded extends TodoState {
  final String message;

  const TodoAdded({required this.message});

  @override
  List<Object> get props => [message];
}
