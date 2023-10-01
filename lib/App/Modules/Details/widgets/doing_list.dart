import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/App/Core/utils/extensions.dart';
import 'package:to_do_app/App/Modules/Home/controller.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
          ? Column(
              children: [
                Image.asset(
                  'assets/images/task.jpg',
                  fit: BoxFit.cover,
                  width: 65.0.wp,
                ),
                Text(
                  'Add Task',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0.sp,
                  ),
                ),
              ],
            )
          : ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                ...homeCtrl.doingTodos
                      .map((element) => Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 2.0.wp,
                            horizontal: 2.0.wp,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 10,
                                child: Checkbox(
                                  fillColor: MaterialStateProperty.resolveWith(
                                      (states) => Colors.grey),
                                  value: element['Done'] ?? false,
                                  onChanged: (value) {
                                    homeCtrl.doneTodo(element['title']);
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 2.0.wp,
                                ),
                                child: Text(
                                  element['title'],
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
                if(homeCtrl.doingTodos.isNotEmpty)
                  Padding(
                    padding:  EdgeInsets.symmetric(
                      horizontal: 2.0.wp,
                    ),
                    child: Divider(
                      thickness: 2,

                    ),
                  ),

              ],
            ),
    );
  }
}
