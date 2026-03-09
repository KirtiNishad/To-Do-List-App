part of 'task_bloc.dart';

sealed class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskModel> tasks;

  TaskLoaded(this.tasks);
}

class TaskError extends TaskState {
  final String msg;

  TaskError(this.msg);
}