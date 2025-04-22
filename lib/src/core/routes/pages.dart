library;

import 'package:flutter/material.dart';
import 'package:todopractise/src/features/todo/presentation/pages/add_todo_page.dart';
import 'package:todopractise/src/features/todo/presentation/pages/todo_details_page.dart';
import 'package:todopractise/src/features/todo/presentation/pages/todos_page.dart';
import 'package:todopractise/src/features/todo/presentation/pages/update_todo_page.dart';

import '/src/core/error/error.dart';
import 'routes.dart';

class AppRoute {
  static const initial = RoutesName.initial;
  static Route<dynamic> generate(RouteSettings? settings) {
    switch (settings?.name) {
      case RoutesName.initial:
        return MaterialPageRoute(builder: (_) => const TodoPage(), settings: settings);
      case RoutesName.addTodo:
        return MaterialPageRoute(builder: (_) => const AddTodoPage(), settings: settings);
      case RoutesName.updateTodo:
        final String? todoId = settings?.arguments as String?;
        if (todoId == null) {
          throw RouteFailure('Todo ID is required for update');
        }
        return MaterialPageRoute(builder: (_) => UpdateTodoPage(todoId: todoId), settings: settings);
      case RoutesName.todoDetails:
        final String? todoId = settings?.arguments as String?;
        if (todoId == null) {
          throw RouteFailure('Todo ID is required for details');
        }
        return MaterialPageRoute(builder: (_) => TodoDetailsPage(todoId: todoId), settings: settings);
      default:
        // If there is no such named route in the switch statement
        throw RouteFailure('${settings?.name} Route not found!');
    }
  }
}
