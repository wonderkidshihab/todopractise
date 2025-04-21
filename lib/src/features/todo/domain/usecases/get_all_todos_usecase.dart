import 'package:fpdart/fpdart.dart';
import 'package:todopractise/src/core/error/error.dart';
import 'package:todopractise/src/core/usecases/usecases.dart';
import 'package:todopractise/src/features/todo/domain/entities/todo.dart';
import 'package:todopractise/src/features/todo/domain/repositories/todo_repository.dart';

class GetAllTodosUsecase extends UseCase<Either<Failure, List<Todo>>, NoParams> {
  final TodoRepository _repository;
  const GetAllTodosUsecase({required TodoRepository repository}) : _repository = repository;

  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) async {
    return await _repository.getTodos();
  }
}
