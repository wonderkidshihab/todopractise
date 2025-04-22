import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todopractise/src/core/utils/date_format.dart';
import 'package:todopractise/src/features/todo/domain/entities/todo.dart';
import 'package:todopractise/src/features/todo/presentation/bloc/todo_bloc.dart';

class TodoDetailsBody extends StatelessWidget {
  final Todo todo;
  const TodoDetailsBody({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(todo.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
              InkWell(
                onTap: () async {
                  context.read<TodoBloc>().add(
                    UpdateTodoEvent(
                      id: todo.id,
                      isCompleted: !todo.isCompleted,
                      title: todo.title,
                      description: todo.description,
                      updatedAt: DateTime.now(),
                      createdAt: todo.createdAt,
                    ),
                  );
                },
                child: Chip(
                  label: Text(todo.isCompleted ? 'Completed' : 'Pending', style: const TextStyle(color: Colors.white)),
                  backgroundColor: todo.isCompleted ? Colors.green : Colors.amber,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              ),
            ],
          ),
          Text(
            'Updated at: ${formatDatedMMMyyyy(todo.updatedAt)}',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Divider(),
          const SizedBox(height: 8),
          Text(todo.description, style: const TextStyle(fontSize: 16, height: 2)),
        ],
      ),
    );
  }
}
