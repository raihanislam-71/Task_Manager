import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class AddNewTaskController extends GetxController{
  bool _addNewTaskInProgress = false;
  String _errorMassage = '';

  bool get addNewTaskInProgress => _addNewTaskInProgress;
  String get errorMassage => _errorMassage;

  Future<bool> getAddNewTask(String title, String description) async {
    bool isSuccess = false;
    _addNewTaskInProgress = true;
    update();

    Map<String, dynamic> requestData = {
      "title": title,
      "description": description,
      "status": "New",
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      Urls.createTask,
      body: requestData,
    );

    if  (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMassage =  response.errorMassage ?? "New task add failed! try again.";
    }

    _addNewTaskInProgress = false;
    update();

    return isSuccess;
  }
}