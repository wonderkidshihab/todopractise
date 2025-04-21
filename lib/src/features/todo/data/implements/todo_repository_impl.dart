import 'package:fpdart/fpdart.dart';
import 'package:todopractise/src/core/error/error.dart';
import 'package:todopractise/src/features/todo/data/models/todo_model.dart';
import 'package:todopractise/src/features/todo/data/sources/todo_local_data_source.dart';
import 'package:todopractise/src/features/todo/domain/entities/todo.dart';
import 'package:todopractise/src/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource _localDataSource;
  const TodoRepositoryImpl({required TodoLocalDataSource localDataSource}) : _localDataSource = localDataSource;
  @override
  Future<Either<Failure, void>> addTodo(Todo todo) async {
    try {
      await _localDataSource.addTodo(TodoModel.fromEntity(todo));
      return const Right(null);
    } on Exception catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(String id) async {
    try {
      await _localDataSource.deleteTodo(id);
      return const Right(null);
    } on Exception catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Todo>> getTodo(String id) async {
    try {
      final todo = await _localDataSource.getTodo(id);
      return Right(todo);
    } on Exception catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    try {
      final todos = await _localDataSource.getTodos();
      return Right(todos);
    } on Exception catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTodo(Todo todo) async {
    try {
      await _localDataSource.updateTodo(TodoModel.fromEntity(todo));
      return const Right(null);
    } on Exception catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
