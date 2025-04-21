import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todopractise/src/core/utils/show_snackbar.dart';
import 'package:todopractise/src/features/todo/domain/entities/todo.dart';
import 'package:todopractise/src/features/todo/presentation/bloc/todo_bloc.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  const TodoCard(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Dismissible(
        key: Key(todo.id),
        background: Container(
          color: Colors.red,
          child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(padding: EdgeInsets.all(16.0), child: Icon(Icons.delete, color: Colors.white)),
          ),
        ),
        onDismissed: (direction) {
          showSnackBar(context, "Todo deleted");
        },
        confirmDismiss: (direction) async {
          final result = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('Do you want to delete this todo?'),
                actions: [
                  TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
                  TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Delete')),
                ],
              );
            },
          );
          if (result && context.mounted) {
            context.read<TodoBloc>().add(DeleteTodoEvent(id: todo.id));
          }
          return result;
        },
        child: ListTile(
          title: Text(todo.title),
          subtitle: Text(todo.description),
          trailing: IconButton(
            icon: const Icon(Icons.check_circle),
            onPressed: () {
              context.read<TodoBloc>().add(
                UpdateTodoEvent(
                  id: todo.id,
                  title: todo.title,
                  description: todo.description,
                  createdAt: todo.createdAt,
                  updatedAt: DateTime.now(),
                  isCompleted: !todo.isCompleted,
                  completedAt: todo.isCompleted ? DateTime.now() : null,
                ),
              );
            },
          ),
          tileColor: todo.isCompleted ? Colors.green : Colors.amber,
        ),
      ),
    );
  }
}
