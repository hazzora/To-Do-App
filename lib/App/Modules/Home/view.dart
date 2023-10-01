import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:to_do_app/App/Core/utils/keys.dart';
import 'package:to_do_app/App/Core/values/colors.dart';
import 'package:to_do_app/App/Modules/Home/Widgets/add_dialog.dart';
import 'package:to_do_app/App/Modules/Home/controller.dart';
import 'package:to_do_app/App/Core/utils/extensions.dart';
import 'package:to_do_app/App/Modules/Report/view_report.dart';

import '../../Data/models/task.dart';
import 'Widgets/add_card.dart';
import 'Widgets/task_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: purple,
          title: Center(
            child: Text(
              'To Do App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0.sp,
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: Obx(
          () => IndexedStack(
            index: controller.tabIndex.value,
            children: [
              ListView(
                children: [
                  Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children: [
                        ...controller.tasks
                            .map(
                              (element) => LongPressDraggable(
                                data: element,
                                onDragStarted: () =>
                                    controller.changeDeleting(true),
                                onDraggableCanceled: (_, __) =>
                                    controller.changeDeleting(false),
                                onDragEnd: (_) =>
                                    controller.changeDeleting(false),
                                feedback: Opacity(
                                  opacity: 0.8,
                                  child: TaskCard(
                                    task: element,
                                  ),
                                ),
                                child: TaskCard(
                                  task: element,
                                ),
                              ),
                            )
                            .toList(),
                        AddCard(),
                      ],
                    ),
                  ),
                ],
              ),
              ReportPage(),
            ],
          ),
        ),
        floatingActionButton: DragTarget<Task>(
          builder: (_, __, ___) {
            return Obx(
              () => FloatingActionButton(
                backgroundColor: controller.deleting.value ? Colors.red : purple,
                onPressed: () {
                  if (controller.tasks.isNotEmpty) {
                    Get.to(
                      () => AddDialog(),
                      transition: Transition.downToUp,
                    );
                  } else {
                    EasyLoading.showInfo('Please create your task type');
                  }
                },
                child:
                    Icon(controller.deleting.value ? Icons.delete : Icons.add),
              ),
            );
          },
          onAccept: (Task task) {
            controller.deleteTask(task);
            EasyLoading.showSuccess('Delete Success');
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: purple,
          ),
          child: Obx(
            () => BottomNavigationBar(
                backgroundColor: Colors.grey[200],
                selectedItemColor:purple,
              onTap: (int index) => controller.changeTabIndex(index),
              currentIndex: controller.tabIndex.value,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: const Icon(Icons.apps),
                ),
                BottomNavigationBarItem(
                  label: 'Report',
                  icon: const Icon(Icons.data_usage),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
