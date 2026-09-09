import 'package:get/get.dart';
import 'package:task_manager_app/data/models/task_model.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_wrapper_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class InProgressController extends GetxController{
  bool _getProgressTaskInProgress = false;
  List<TaskModel> _inProgressTaskList = [];
  String _errorMassage = '';

  bool get getProgressTaskInProgress => _getProgressTaskInProgress;
  List<TaskModel> get inProgressTaskList => _inProgressTaskList;
  String get errorMassage => _errorMassage;

  Future<bool> getInProgressTask() async {
    bool isSuccess = false;
    _getProgressTaskInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.progressTasks,
    );

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel = TaskListWrapperModel.fromJson(
        response.responseData,
      );
      _inProgressTaskList = taskListWrapperModel.taskList ?? [];
    } else {
       _errorMassage = response.errorMassage ?? 'Get inProgress task failed! try again.';
    }

    _getProgressTaskInProgress = false;
    update();

    return isSuccess;
  }
}