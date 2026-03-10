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
      appBar: AppBar(title: const Text("My Tasks"), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is TaskLoaded) {
              if (state.tasks.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.task_alt, size: 80, color: Colors.grey),
                      SizedBox(height: 10),
                      Text("No Tasks Yet", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                );
              }

              return ListView.builder(
                itemCount: state.tasks.length,
                itemBuilder: (context, index) {
                  final task = state.tasks[index];

                  return Dismissible(
                    key: Key(task.id),

                    background: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),

                    onDismissed: (_) {
                      context.read<TaskBloc>().add(DeleteTask(task.id));
                    },

                    child: Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 6),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: ListTile(
                        leading: Checkbox(
                          value: task.isCompleted,
                          onChanged: (value) {
                            context.read<TaskBloc>().add(
                              ToggleTask(task.id, value!),
                            );
                          },
                        ),

                        title: Text(
                          task.title,
                          style: TextStyle(
                            fontSize: 16,
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _showEditDialog(context, task);
                              },
                            ),

                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                context.read<TaskBloc>().add(
                                  DeleteTask(task.id),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),

                title: const Text("Add Task"),

                content: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "Enter task title",
                    border: OutlineInputBorder(),
                  ),
                ),

                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      if (controller.text.trim().isNotEmpty) {
                        context.read<TaskBloc>().add(
                          AddTask(controller.text.trim()),
                        );

                        controller.clear();

                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Add"),
                  ),
                ],
              );
            },
          );
        },

        icon: const Icon(Icons.add),
        label: const Text("Add Task"),
      ),
    );
  }

  void _showEditDialog(BuildContext context, task) {
    final controller = TextEditingController(text: task.title);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Edit Task"),

          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter task title",
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                final newTitle = controller.text.trim();

                if (newTitle.isNotEmpty) {
                  context.read<TaskBloc>().add(EditTask(task.id, newTitle));

                  Navigator.pop(context);
                }
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
