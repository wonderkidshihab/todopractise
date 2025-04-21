import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TodoDetailsPage extends StatelessWidget {
  final String todoId;
  const TodoDetailsPage({super.key, required this.todoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Todo Details Page'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back to Todos'),
            ),
          ],
        ),
      ),
    );
  }
}