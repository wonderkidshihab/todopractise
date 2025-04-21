import 'package:flutter/material.dart';

import 'app_root.dart';
import 'src/core/config/config.dart';

Future<void> main() async {
  //  Here we are calling the Dependency Injection
  await DependencyInjection.init();
  //  This is the main app
  runApp(const RootApp());
}
