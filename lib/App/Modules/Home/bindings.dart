import 'package:get/get.dart';
import 'package:to_do_app/App/Data/providers/task/provider.dart';
import 'package:to_do_app/App/Data/services/storage/repository.dart';
import 'package:to_do_app/App/Modules/Home/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
