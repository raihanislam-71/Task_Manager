import 'package:get/get.dart';
import 'package:task_manager_app/data/models/task_model.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_wrapper_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class NewTaskController extends GetxController {
  bool _getNewTaskInProgress = false;
  List<TaskModel> _taskList = [];
  String _errorMessage = '';

  bool get getNewTaskInProgress => _getNewTaskInProgress;
  List<TaskModel> get newTaskList => _taskList;
  String get errorMessage => _errorMessage;

  Future<bool> getNewTasks() async {
    bool isSuccess = false;
    _getNewTaskInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(Urls.newTasks);
    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel = TaskListWrapperModel.fromJson(
        response.responseData,
      );
      _taskList = taskListWrapperModel.taskList ?? [];
      isSuccess = true;
    } else {
      _errorMessage =
          response.errorMassage ?? 'Get new task failed! try again.';
    }
    _getNewTaskInProgress = false;
    update();

    return isSuccess;
  }
}
