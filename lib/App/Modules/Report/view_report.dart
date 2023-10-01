import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:to_do_app/App/Core/utils/extensions.dart';
import 'package:to_do_app/App/Core/values/colors.dart';
import 'package:to_do_app/App/Modules/Home/controller.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Obx(() {
        var createdTasks = homeCtrl.getTotalTask();
        var completedTasks = homeCtrl.getTotalDoneTask();
        var liveTasks = createdTasks - completedTasks;
        var percent = (completedTasks / createdTasks * 100).toStringAsFixed(0);
        return ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 3.0.wp,
                top: 2.0.wp,
              ),
              child: Text(
                'My Report',
                style: TextStyle(
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 3.0.wp,
                vertical: 2.0.wp,
              ),
              child: Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: TextStyle(
                  fontSize: 14.0.sp,
                  color: Colors.grey,
                ),
              ),
            ),
            Divider(
              thickness: 2,
              indent: 15,
              endIndent: 15,
            ),
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatus(Colors.green, liveTasks, 'Live Tasks'),
                  _buildStatus(
                      Colors.orange, completedTasks, 'Completed Tasks'),
                  _buildStatus(Colors.blue, createdTasks, 'Created Tasks'),
                ],
              ),
            ),
            SizedBox(
              height: 8.0.wp,
            ),
            UnconstrainedBox(
              child: SizedBox(
                width: 40.0.wp,
                height: 40.0.wp,
                child: CircularStepProgressIndicator(
                  totalSteps: createdTasks == 0 ? 1 : createdTasks,
                  currentStep: completedTasks,
                  stepSize: 20,
                  selectedColor: green,
                  unselectedColor: Colors.grey[200],
                  padding: 0,
                  width: 180,
                  height: 180,
                  selectedStepSize: 22,
                  roundedCap: (_, __) => true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${createdTasks == 0 ? 0 : percent} %',
                      style: TextStyle(
                        fontSize: 20.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      SizedBox(height: 2.0.wp,),
                      Text('Efficiency',
                        style: TextStyle(
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    ));
  }
}

Row _buildStatus(Color color, int number, String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 14,
        width: 14,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 0.3.wp,
            color: color,
          ),
        ),
      ),
      SizedBox(
        width: 4,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number',
            style: TextStyle(
              fontSize: 12.0.sp,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 2.0.wp,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 11.0.sp,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ],
  );
}
