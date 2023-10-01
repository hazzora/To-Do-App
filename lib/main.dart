import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:to_do_app/App/Data/services/storage/services.dart';
import 'package:to_do_app/App/Modules/Home/bindings.dart';
import 'package:to_do_app/App/Modules/Home/view.dart';
import 'package:get_storage/get_storage.dart';


void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'To Do App ',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    );
  }
}
