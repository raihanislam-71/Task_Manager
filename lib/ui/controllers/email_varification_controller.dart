import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class EmailVarificationController extends GetxController{
  bool _emailVarificationInProgress = false;
  String _errorMassage = '';

  bool get emailVarificationInProgress => _emailVarificationInProgress;
  String get errorMassage => _errorMassage;

  Future<bool> emailVarification(String email) async {
    bool isSuccess = false;
    _emailVarificationInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.recoverVerifyEmail(email),
    );

    if (response.isSuccess && response.responseData['status'] == 'success') {
      isSuccess = true;
    } else {
       _errorMassage =  response.responseData?['data'] ?? "Verification failed! Try again.";
    }
    _emailVarificationInProgress = false;
    update();

    return isSuccess;
  }
}