import 'package:fpdart/fpdart.dart';
import 'package:todopractise/src/core/error/error.dart';
import 'package:todopractise/src/core/usecases/usecases.dart';
import 'package:todopractise/src/features/todo/domain/repositories/todo_repository.dart';

class DeleteTodoUsecase extends UseCase<Either<Failure, void>, String> {
  final TodoRepository _repository;
  const DeleteTodoUsecase({required TodoRepository repository}) : _repository = repository;

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await _repository.deleteTodo(params);
  }
}
