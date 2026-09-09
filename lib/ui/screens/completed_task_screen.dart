import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controllers/completed_controller.dart';
import '../widgets/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {

  @override
  void initState() {
    super.initState();
    _initialCall();
  }

  void _initialCall(){
    Get.find<CompletedController>().getCompletedTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => _initialCall(),
        child: GetBuilder<CompletedController>(
          builder: (completedController) {
            return Visibility(
              visible: completedController.getCompletedTaskInProgress == false,
              replacement: const Center(child: CircularProgressIndicator()),
              child: ListView.builder(
                itemCount: completedController.completedTaskList.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                    taskModel: completedController.completedTaskList[index],
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
