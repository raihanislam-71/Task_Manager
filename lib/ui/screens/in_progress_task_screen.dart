import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controllers/in_progress_controller.dart';
import '../widgets/task_item.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {

  @override
  void initState() {
    super.initState();
    _initialCall();
  }

  void _initialCall() {
    Get.find<InProgressController>().getInProgressTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => _initialCall(),
        child: GetBuilder<InProgressController>(
          builder: (inProgressController) {
            return Visibility(
              visible: inProgressController.getProgressTaskInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.builder(
                itemCount: inProgressController.inProgressTaskList.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                    taskModel: inProgressController.inProgressTaskList[index],
                    onUpdateTask: () {
                      _initialCall();
                    },
                  );
                },
              ),
            );
          }
        ),
      ),
    );
  }
}
