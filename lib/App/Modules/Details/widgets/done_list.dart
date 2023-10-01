import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/App/Core/utils/extensions.dart';
import 'package:to_do_app/App/Modules/Home/controller.dart';

import '../../../Core/values/colors.dart';

class DoneList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  DoneList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doneTodos.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 2.0.wp,
                    horizontal: 2.0.wp,
                  ),
                  child: Text(
                    'Completed(${homeCtrl.doneTodos.length})',
                    style: TextStyle(
                      fontSize: 14.0.sp,
                        color: Colors.grey,
                    ),
                  ),
                ),
                ...homeCtrl.doneTodos
                    .map(
                      (element) => Dismissible(
                        key: ObjectKey(element),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) =>
                            homeCtrl.deleteDoneTodo(element),
                        background: Container(
                          color: Colors.red.withOpacity(0.8),
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding:  EdgeInsets.only(
                              right: 2.0.wp,
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 3.0.wp,
                            horizontal: 2.0.wp,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Icon(
                                  Icons.done,
                                  color: blue,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 2.0.wp,
                                ),
                                child: Text(
                                  element['title'] ?? 'Invalid Title',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList()
              ],
            )
          : Container(),
    );
  }
}
