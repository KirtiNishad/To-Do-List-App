part of 'task_bloc.dart';

sealed class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final String title;
  AddTask(this.title);
}

class ToggleTask extends TaskEvent {
  final String id;
  final bool status;

  ToggleTask(this.id, this.status);
}

class EditTask extends TaskEvent {
  final String id;
  final String title;

  EditTask(this.id, this.title);
}

class DeleteTask extends TaskEvent {
  final String id;
  DeleteTask(this.id);
}