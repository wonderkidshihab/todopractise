import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todopractise/src/core/config/injection.dart';
import 'package:todopractise/src/core/routes/names.dart';
import 'package:todopractise/src/core/utils/show_snackbar.dart';
import 'package:todopractise/src/core/widgets/loader.dart';
import 'package:todopractise/src/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todopractise/src/features/todo/presentation/widgets/todo_card.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.addTodo);
            },
          ),
        ],
      ),
      body: BlocProvider<TodoBloc>(
        create: (context) => sl<TodoBloc>()..add(GetAllTodosEvent()),
        child: BlocListener<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state is TodoError) {
              showSnackBar(context, state.message);
            } else if (state is TodoUpdated) {
              showSnackBar(context, state.message);
              context.read<TodoBloc>().add(GetAllTodosEvent());
            } else if (state is TodoDeleted) {
              showSnackBar(context, state.message);
              context.read<TodoBloc>().add(GetAllTodosEvent());
            }
          },
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (_, state) {
              return switch (state) {
                TodoInitial() => Loader(),
                TodoLoading() => Loader(),
                TodoLoaded(todos: final todos) => ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return TodoCard(todo);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 16);
                  },
                ),
                TodoError(message: final message) => Center(child: Text(message)),
                TodoEmpty() || _ => const Center(child: Text('No Todos')),
              };
            },
          ),
        ),
      ),
    );
  }
}
