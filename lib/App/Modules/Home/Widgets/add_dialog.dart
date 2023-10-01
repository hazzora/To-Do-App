import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:to_do_app/App/Core/utils/extensions.dart';
import 'package:to_do_app/App/Core/values/colors.dart';
import 'package:to_do_app/App/Modules/Home/controller.dart';

class AddDialog extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: purple,
          automaticallyImplyLeading: false,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:  EdgeInsets.only(right: 10.0.wp),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                      homeCtrl.editCtrl.clear();
                      homeCtrl.changeTask(null);
                    },
                    icon:  Icon(Icons.close),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(right: 10.0.wp),
                  child: Text(
                    'New Task',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {
                    if (homeCtrl.formKey.currentState!.validate()) {
                      if (homeCtrl.task.value == null) {
                        EasyLoading.showError('Please select the task type');
                      } else {
                        var success = homeCtrl.updateTask(
                          homeCtrl.task.value!,
                          homeCtrl.editCtrl.text,
                        );

                        if (success) {
                          EasyLoading.showSuccess('ToDo item add success');
                          Get.back();
                          homeCtrl.changeTask(null);
                        } else {
                          EasyLoading.showError('ToDo item already exist');
                        }
                        homeCtrl.editCtrl.clear();
                      }
                    }
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 15.0.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Form(
          key: homeCtrl.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.0.wp),
                child: TextFormField(
                  controller: homeCtrl.editCtrl,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                  ),
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please Enter Your ToDo Item';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 2.0.wp,
                  bottom: 2.0.wp,
                  left: 2.0.wp,
                ),
                child: Text(
                  'Add To: ',
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
              ...homeCtrl.tasks
                  .map(
                    (element) => Obx(
                      () => InkWell(
                        onTap: () => homeCtrl.changeTask(element),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.0.wp, horizontal: 2.0.wp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    IconData(
                                      element.icon,
                                      fontFamily: 'MyCustomIconFont',
                                    ),
                                    color: HexColor.fromHex(
                                      element.color.substring(4),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3.0.wp,
                                  ),
                                  Text(
                                    element.title,
                                    style: TextStyle(
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              if (homeCtrl.task.value == element)
                                 Icon(
                                  Icons.check,
                                  color: Colors.blue,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
