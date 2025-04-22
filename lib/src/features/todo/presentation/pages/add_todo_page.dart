import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todopractise/src/core/config/config.dart';
import 'package:todopractise/src/core/routes/names.dart';
import 'package:todopractise/src/core/utils/show_snackbar.dart';
import 'package:todopractise/src/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:uuid/uuid.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (context) => sl<TodoBloc>(),
      child: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoError) {
            showSnackBar(context, state.message);
          }
          if (state is TodoAdded) {
            showSnackBar(context, state.message);
            context.read<TodoBloc>().add(const GetAllTodosEvent());
            Navigator.of(context).pushNamedAndRemoveUntil(RoutesName.initial, (route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Add Todo')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 16,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(labelText: 'Description', alignLabelWithHint: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                      minLines: 3,
                      maxLines: 20,
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              child: ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final todoBloc = BlocProvider.of<TodoBloc>(context);
                    todoBloc.add(
                      AddTodoEvent(
                        id: Uuid().v1(),
                        title: _titleController.text,
                        description: _descriptionController.text,
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                        isCompleted: false,
                        completedAt: null,
                      ),
                    );
                  }
                },
                label: const Text('Save'),
                icon: const Icon(Icons.save),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  minimumSize: const Size(double.infinity, 50),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
