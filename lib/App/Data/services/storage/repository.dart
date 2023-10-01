import 'package:to_do_app/App/Data/providers/task/provider.dart';

import '../../models/task.dart';

class TaskRepository {
  TaskProvider taskProvider;
  TaskRepository({required this.taskProvider});

  List<Task> readTasks() => taskProvider.readTask();

  void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}
