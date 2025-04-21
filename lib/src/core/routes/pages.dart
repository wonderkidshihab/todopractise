library;

import 'package:flutter/material.dart';
import 'package:fluttercleanprojectstarter/src/features/todo/presentation/pages/pages.dart';

import '/src/core/error/error.dart';
import 'routes.dart';

class AppRoute {
  static const initial = RoutesName.initial;
  static Route<dynamic> generate(RouteSettings? settings) {
    switch (settings?.name) {
      case RoutesName.initial:
        return MaterialPageRoute(builder: (_) => const TodoPage(), settings: settings);

      default:
        // If there is no such named route in the switch statement
        throw RouteFailure('${settings?.name} Route not found!');
    }
  }
}
