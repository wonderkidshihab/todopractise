import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todopractise/src/core/config/injection.dart';
import 'package:todopractise/src/core/routes/routes.dart';
import 'package:todopractise/src/core/utils/show_snackbar.dart';
import 'package:todopractise/src/core/widgets/loader.dart';
import 'package:todopractise/src/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todopractise/src/features/todo/presentation/pages/todo_details_body.dart';

class TodoDetailsPage extends StatelessWidget {
  final String todoId;
  const TodoDetailsPage({super.key, required this.todoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.updateTodo, arguments: todoId);
            },
          ),
        ],
      ),
      body: BlocProvider<TodoBloc>(
        create: (context) => sl<TodoBloc>()..add(GetTodoEvent(id: todoId)),
        child: BlocListener<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state is TodoError) {
              showSnackBar(context, state.message);
            } else if (state is TodoUpdated) {
              showSnackBar(context, state.message);
              context.read<TodoBloc>().add(GetTodoEvent(id: todoId));
            } else if (state is TodoDeleted) {
              showSnackBar(context, state.message);
              Navigator.pop(context);
            }
          },
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              return switch (state) {
                TodoInitial() || TodoLoading() => Loader(),
                SingleTodoLoaded(todo: final todo) => TodoDetailsBody(todo: todo),
                TodoError(message: final message) => Center(child: Text(message)),
                _ => const Center(child: Text('No Todo Found')),
              };
            },
          ),
        ),
      ),
    );
  }
}
