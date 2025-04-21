import 'package:flutter/material.dart';

class UpdateTodoPage extends StatelessWidget {
  final String todoId;
  const UpdateTodoPage({super.key, required this.todoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Todo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Update Todo Page'),
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
