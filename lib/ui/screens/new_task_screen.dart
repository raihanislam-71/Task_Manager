import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controllers/new_task_controller.dart';
import 'package:task_manager_app/ui/controllers/task_count_controller.dart';
import 'package:task_manager_app/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_app/ui/utility/app_colors.dart';
import '../widgets/task_item.dart';
import '../widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

  @override
  void initState() {
    super.initState();
    _initialCall();
  }

  void _initialCall() {
    Get.find<NewTaskController>().getNewTasks();
    Get.find<TaskCountController>().getTaskCountByStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummarySection(),
            const SizedBox(height: 8),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => _initialCall(),
                child: GetBuilder<NewTaskController>(
                  builder: (newTaskController) {
                    return Visibility(
                      visible: newTaskController.getNewTaskInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ListView.builder(
                        itemCount: newTaskController.newTaskList.length,
                        itemBuilder: (context, index) {
                          return TaskItem(
                            taskModel: newTaskController.newTaskList[index],
                            onUpdateTask: _initialCall,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddButton,
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onTapAddButton() async {
    final bool? autoRefresh = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNewTaskScreen()),
    );

    if (autoRefresh == true) {
      _initialCall();
    }
  }

  Widget _buildSummarySection() {
    return GetBuilder<TaskCountController>(
      builder: (taskCountController) {
        return Visibility(
          visible: taskCountController.getTaskCountByStatusInProgress == false,
          replacement: const SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: taskCountController.taskCountByStatusList.map((e) {
                return TaskSummaryCard(
                  title: (e.sId ?? 'Unknown').toUpperCase(),
                  count: e.sum.toString(),
                );
              }).toList(),
            ),
          ),
        );
      }
    );
  }
}
