import 'package:get/get.dart';
import 'package:task_manager_app/data/models/task_count_by_status_model.dart';
import '../../data/models/network_response.dart';
import '../../data/models/task_by_status_count_wrapper_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class TaskCountController extends GetxController {
  bool _getTaskCountByStatusInProgress = false;
  List<TaskCountByStatusModel> _taskCountByStatusList = [];
  String _errorMassage = '';

  bool get getTaskCountByStatusInProgress => _getTaskCountByStatusInProgress;
  List<TaskCountByStatusModel> get taskCountByStatusList =>
      _taskCountByStatusList;
  String get errorMassage => _errorMassage;

  Future<bool> getTaskCountByStatus() async {
    bool isSuccess = false;
    _getTaskCountByStatusInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.taskStatusCount,
    );

    if (response.isSuccess) {
      TaskCountByStatusWrapperModel taskCountByStatusWrapperModel =
          TaskCountByStatusWrapperModel.fromJson(response.responseData);

      _taskCountByStatusList =
          taskCountByStatusWrapperModel.taskCountByStatusList ?? [];
    } else {
      _errorMassage =
          response.errorMassage ??
          "Get task count bu status failed! try again.";
    }
    _getTaskCountByStatusInProgress = false;
    update();

    return isSuccess;
  }
}
