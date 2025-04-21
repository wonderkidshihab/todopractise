import 'package:fpdart/fpdart.dart';
import 'package:todopractise/src/core/error/error.dart';
import 'package:todopractise/src/core/usecases/usecases.dart';
import 'package:todopractise/src/features/todo/domain/entities/todo.dart';
import 'package:todopractise/src/features/todo/domain/repositories/todo_repository.dart';

class UpdateTodoUsecase extends UseCase<Either<Failure, void>, UpdateTodoParams> {
  final TodoRepository _repository;
  const UpdateTodoUsecase({required TodoRepository repository}) : _repository = repository;

  @override
  Future<Either<Failure, void>> call(UpdateTodoParams params) async {
    return await _repository.updateTodo(
      Todo(
        id: params.id,
        title: params.title,
        description: params.description,
        createdAt: params.createdAt,
        updatedAt: params.updatedAt,
        isCompleted: params.isCompleted,
      ),
    );
  }
}

class UpdateTodoParams {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isCompleted;
  final DateTime? completedAt;

  const UpdateTodoParams({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.isCompleted,
    this.completedAt,
  });
}
