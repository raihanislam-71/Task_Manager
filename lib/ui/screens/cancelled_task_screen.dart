import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cancelled_controller.dart';
import '../widgets/task_item.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {

  @override
  void initState() {
    super.initState();
    _initialCall();
  }

  void _initialCall() {
    Get.find<CancelledController>().getCancelledTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _initialCall();
        },
        child: GetBuilder<CancelledController>(
            builder: (cancelledController) {
              return Visibility(
                visible: cancelledController.getCancelledTaskInProgress ==
                    false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ListView.builder(
                  itemCount: cancelledController.cancelledTask.length,
                  itemBuilder: (context, index) {
                    return TaskItem(
                      taskModel: cancelledController.cancelledTask[index],
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
