import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class AppObserver extends BlocObserver {
  final Logger logger = Logger(
    printer: PrettyPrinter(methodCount: 0, errorMethodCount: 0, colors: true, printEmojis: true, printTime: true),
  );

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    logger.i('Bloc Created: ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logger.i('Bloc Changed: ${bloc.runtimeType}, Change: $change');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.i('Bloc Event: ${bloc.runtimeType}, Event: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.i('Bloc Transition: ${bloc.runtimeType}, Transition: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logger.e('Bloc Error: ${bloc.runtimeType}, Error: $error, StackTrace: $stackTrace');
  }
}
