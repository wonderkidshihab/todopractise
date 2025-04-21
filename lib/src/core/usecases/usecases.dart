library;

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);

  const UseCase();
}

class NoParams {}
