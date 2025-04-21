import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todopractise/src/core/usecases/usecases.dart';
import 'package:todopractise/src/features/todo/domain/entities/todo.dart';
import 'package:todopractise/src/features/todo/domain/usecases/add_todo_usecase.dart';
import 'package:todopractise/src/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:todopractise/src/features/todo/domain/usecases/get_all_todos_usecase.dart';
import 'package:todopractise/src/features/todo/domain/usecases/get_todo_usecase.dart';
import 'package:todopractise/src/features/todo/domain/usecases/update_todo_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetAllTodosUsecase _getTodosUsecase;
  final GetTodoUsecase _getTodoUsecase;
  final AddTodoUsecase _addTodoUsecase;
  final UpdateTodoUsecase _updateTodoUsecase;
  final DeleteTodoUsecase _deleteTodoUsecase;

  TodoBloc({
    required GetAllTodosUsecase getTodosUsecase,
    required GetTodoUsecase getTodoUsecase,
    required AddTodoUsecase addTodoUsecase,
    required UpdateTodoUsecase updateTodoUsecase,
    required DeleteTodoUsecase deleteTodoUsecase,
  }) : _getTodoUsecase = getTodoUsecase,
       _addTodoUsecase = addTodoUsecase,
       _updateTodoUsecase = updateTodoUsecase,
       _deleteTodoUsecase = deleteTodoUsecase,
       _getTodosUsecase = getTodosUsecase,
       super(TodoInitial()) {
    on<TodoEvent>((event, emit) {
      emit(TodoLoading());
    });
    on<GetAllTodosEvent>(_onGetAllTodos);
    on<GetTodoEvent>(_onGetTodo);
    on<AddTodoEvent>(_onAddTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
  }

  Future<void> _onGetAllTodos(GetAllTodosEvent event, Emitter<TodoState> emit) async {
    final result = await _getTodosUsecase(NoParams());
    emit(
      result.fold(
        (failure) => TodoError(message: failure.message),
        (todos) => todos.isEmpty ? TodoEmpty() : TodoLoaded(todos: todos),
      ),
    );
  }

  Future<void> _onGetTodo(GetTodoEvent event, Emitter<TodoState> emit) async {
    final result = await _getTodoUsecase(event.id);
    emit(result.fold((failure) => TodoError(message: failure.message), (todo) => TodoLoaded(todos: [todo])));
  }

  Future<void> _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    final result = await _addTodoUsecase(event.todo);
    emit(result.fold((failure) => TodoError(message: failure.message), (_) => TodoLoaded(todos: [event.todo])));
  }

  Future<void> _onUpdateTodo(UpdateTodoEvent event, Emitter<TodoState> emit) async {
    final result = await _updateTodoUsecase(event.todo);
    emit(result.fold((failure) => TodoError(message: failure.message), (_) => TodoLoaded(todos: [event.todo])));
  }

  Future<void> _onDeleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) async {
    final result = await _deleteTodoUsecase(event.id);
    emit(result.fold((failure) => TodoError(message: failure.message), (_) => TodoLoaded(todos: [])));
  }
}
