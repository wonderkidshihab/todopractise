library;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todopractise/src/core/api/api.dart';
import 'package:todopractise/src/core/bloc/app_observer.dart';
import 'package:todopractise/src/features/todo/data/implements/todo_repository_impl.dart';
import 'package:todopractise/src/features/todo/data/sources/todo_local_data_source.dart';
import 'package:todopractise/src/features/todo/domain/repositories/todo_repository.dart';

GetIt sl = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = AppObserver();
    // Register core dependencies
    sl.registerSingleton(Dio());
    sl.registerSingleton<ApiInterface>(DioApi(dio: sl<Dio>()));
    // Register database dependencies
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'todo.db');
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(TodoLocalDataSourceImpl.createTable);
      },
    );
    sl.registerSingleton<Database>(database);
    // Register Todo Feature dependencies
    sl.registerSingleton<TodoLocalDataSource>(TodoLocalDataSourceImpl(database: sl<Database>()));
    sl.registerFactory<TodoRepository>(() => TodoRepositoryImpl(localDataSource: sl<TodoLocalDataSource>()));
  }
}
