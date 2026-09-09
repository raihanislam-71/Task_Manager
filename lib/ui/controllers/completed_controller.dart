import 'package:get/get.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import '../../data/models/network_response.dart';
import '../../data/models/task_list_wrapper_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';


class CompletedController extends GetxController{
  bool _getCompletedTaskInProgress = false;
  List<TaskModel> _completedTaskList = [];
  String _errorMassage = '';

  bool get getCompletedTaskInProgress => _getCompletedTaskInProgress;
  List<TaskModel> get completedTaskList => _completedTaskList;
  String get errorMassage => _errorMassage;

  Future<bool> getCompletedTasks() async {
    bool isSuccess = false;
    _getCompletedTaskInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.completedTasks,
    );
    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel = TaskListWrapperModel.fromJson(
        response.responseData,
      );
      _completedTaskList = taskListWrapperModel.taskList ?? [];
      isSuccess = true;
    } else {
        _errorMassage = response.errorMassage ?? 'Get completed task failed! try again.';
    }
    _getCompletedTaskInProgress = false;
    update();

    return isSuccess;
  }
}