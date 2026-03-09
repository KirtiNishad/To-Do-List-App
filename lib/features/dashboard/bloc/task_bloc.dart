import 'package:bloc/bloc.dart';
import 'package:to_do_list_app/core/services/api_base_client.dart';
import '../model/task_model.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final api = ApiBaseClient();

  TaskBloc() : super(TaskInitial()) {
    on<LoadTasks>((event, emit) async {
      try {
        final data = await api.getTasks();

        List<TaskModel> tasks = [];

        data.forEach((key, value) {
          tasks.add(TaskModel.fromJson(key, value));
        });

        emit(TaskLoaded(tasks));
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });

    on<AddTask>((event, emit) async {
      await api.addTask(event.title);

      add(LoadTasks());
    });

    on<ToggleTask>((event, emit) async {
      await api.updateTask(event.id, event.status);

      add(LoadTasks());
    });

    on<DeleteTask>((event, emit) async {
      await api.deleteTask(event.id);

      add(LoadTasks());
    });
  }
}
