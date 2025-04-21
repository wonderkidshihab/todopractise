import 'package:fpdart/fpdart.dart';
import 'package:todopractise/src/core/error/error.dart';
import 'package:todopractise/src/core/usecases/usecases.dart';
import 'package:todopractise/src/features/todo/domain/entities/todo.dart';
import 'package:todopractise/src/features/todo/domain/repositories/todo_repository.dart';

class UpdateTodoUsecase extends UseCase<Either<Failure, void>, Todo> {
  final TodoRepository _repository;
  const UpdateTodoUsecase({required TodoRepository repository}) : _repository = repository;

  @override
  Future<Either<Failure, void>> call(Todo params) async {
    return await _repository.updateTodo(params);
  }
}
