library;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercleanprojectstarter/src/core/api/api.dart';
import 'package:fluttercleanprojectstarter/src/core/bloc/app_observer.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = AppObserver();
    // Register core dependencies
    sl.registerSingleton(Dio());
    sl.registerSingleton<ApiInterface>(DioApi(dio: sl<Dio>()));
  }
}
