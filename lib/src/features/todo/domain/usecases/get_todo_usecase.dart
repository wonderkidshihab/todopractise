import 'package:fpdart/fpdart.dart';
import 'package:todopractise/src/core/error/error.dart';
import 'package:todopractise/src/core/usecases/usecases.dart';
import 'package:todopractise/src/features/todo/domain/entities/todo.dart';
import 'package:todopractise/src/features/todo/domain/repositories/todo_repository.dart';

class GetTodoUsecase extends UseCase<Either<Failure, Todo>, String> {
  final TodoRepository _repository;
  const GetTodoUsecase({required TodoRepository repository}) : _repository = repository;

  @override
  Future<Either<Failure, Todo>> call(String params) async {
    return await _repository.getTodo(params);
  }
}
