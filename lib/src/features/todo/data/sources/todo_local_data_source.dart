import 'package:sqflite/sqflite.dart';
import 'package:todopractise/src/features/todo/data/models/todo_model.dart';
import 'package:todopractise/src/features/todo/domain/entities/todo.dart';

abstract interface class TodoLocalDataSource {
  Future<List<Todo>> getTodos();
  Future<Todo> getTodo(String id);
  Future<void> addTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final Database _database;
  TodoLocalDataSourceImpl({required Database database}) : _database = database;

  static String get tableName => 'todos';
  static String get createTable => '''
    CREATE TABLE $tableName (
      id TEXT PRIMARY KEY,
      title TEXT,
      description TEXT,
      createdAt INTEGER,
      updatedAt INTEGER,
      isCompleted INTEGER
    )
  ''';

  @override
  Future<void> addTodo(TodoModel todo) async {
    await _database.insert('todos', todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteTodo(String id) async {
    await _database.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<Todo> getTodo(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query('todos', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return TodoModel.fromMap(maps.first);
    } else {
      throw Exception('Todo not found');
    }
  }

  @override
  Future<List<Todo>> getTodos() async {
    final List<Map<String, dynamic>> maps = await _database.query('todos');
    return List.generate(maps.length, (i) {
      return TodoModel.fromMap(maps[i]);
    });
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    await _database.update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }
}
