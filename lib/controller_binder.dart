import 'package:get/get.dart';
import 'package:task_manager_app/ui/controllers/add_new_task_controller.dart';
import 'package:task_manager_app/ui/controllers/cancelled_controller.dart';
import 'package:task_manager_app/ui/controllers/completed_controller.dart';
import 'package:task_manager_app/ui/controllers/email_varification_controller.dart';
import 'package:task_manager_app/ui/controllers/in_progress_controller.dart';
import 'package:task_manager_app/ui/controllers/new_task_controller.dart';
import 'package:task_manager_app/ui/controllers/sign_in_controller.dart';
import 'package:task_manager_app/ui/controllers/sign_up_controller.dart';
import 'package:task_manager_app/ui/controllers/task_count_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => NewTaskController());
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => CancelledController());
    Get.lazyPut(() => CompletedController());
    Get.lazyPut(() => InProgressController());
    Get.lazyPut(() => AddNewTaskController());
    Get.lazyPut(() => TaskCountController());
    Get.lazyPut(() => EmailVarificationController());
  }
}