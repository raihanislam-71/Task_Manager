import 'package:get/get.dart';
import 'package:task_manager_app/data/models/task_model.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_wrapper_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class CancelledController extends GetxController{
  bool _getCancelledTaskInProgress = false;
  List<TaskModel> _cancelledTask = [];
  String _errorMassage = '';

  bool get getCancelledTaskInProgress => _getCancelledTaskInProgress;
  List<TaskModel> get cancelledTask => _cancelledTask;
  String get errorMassage => _errorMassage;

  Future<bool> getCancelledTask() async {
    bool isSuccess = false;
    _getCancelledTaskInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.cancelledTasks,
    );

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel = TaskListWrapperModel.fromJson(
        response.responseData,
      );
      _cancelledTask = taskListWrapperModel.taskList ?? [];
      isSuccess = true;
    } else {
       _errorMassage = response.errorMassage ?? 'Get cancelled task failed! try again.';
    }
    _getCancelledTaskInProgress = false;
    update();

    return isSuccess;
  }
}
