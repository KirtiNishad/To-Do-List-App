import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/task_bloc.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<TaskBloc>().add(LoadTasks());

    return Scaffold(
      appBar: AppBar(title: const Text("My Tasks")),

      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TaskLoaded) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];

                return ListTile(
                  title: Text(task.title),

                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) {
                      context.read<TaskBloc>().add(ToggleTask(task.id, value!));
                    },
                  ),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<TaskBloc>().add(DeleteTask(task.id));
                    },
                  ),
                );
              },
            );
          }

          return const Center(child: Text("No Tasks"));
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text("Add Task"),

                content: TextField(controller: controller),

                actions: [
                  TextButton(
                    onPressed: () {
                      context.read<TaskBloc>().add(AddTask(controller.text));

                      controller.clear();

                      Navigator.pop(context);
                    },
                    child: const Text("Add"),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
