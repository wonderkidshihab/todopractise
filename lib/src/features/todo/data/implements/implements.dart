
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class TodoRepositoryImp implements TodoRepository{

        final TodoRemoteDataSource remoteDataSource;
        TodoRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    