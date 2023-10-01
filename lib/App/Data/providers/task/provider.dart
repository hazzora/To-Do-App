import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:to_do_app/App/Core/utils/keys.dart';
import 'package:to_do_app/App/Data/services/storage/services.dart';

import '../../models/task.dart';

class TaskProvider {
  final _storage = Get.find<StorageService>();

  // {'tasks' :[
  // {
  //   'title': 'Work',
  // 'color' : '0xFF842262',
  // 'icon': 0xe11c
  // }
  //   ]}

  List<Task> readTask() {
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

void writeTasks(List<Task> tasks){
    _storage.write(taskKey, jsonEncode(tasks));
}

}
