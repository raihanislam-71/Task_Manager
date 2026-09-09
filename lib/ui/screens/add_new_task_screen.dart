import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controllers/add_new_task_controller.dart';
import 'package:task_manager_app/ui/widgets/background_widget.dart';
import 'package:task_manager_app/ui/widgets/profile_app_bar.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoRefresh = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        Navigator.pop(context, _autoRefresh);
      },
      child: Scaffold(
        appBar: profileAppBar(context),
        body: BackgroundWidget(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleTEController,
                      decoration: const InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter title";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _descriptionTEController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter description";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    GetBuilder<AddNewTaskController>(
                      builder: (addNewTaskController) {
                        return Visibility(
                          visible:
                              addNewTaskController.addNewTaskInProgress ==
                              false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                            onPressed: _addNewTask,
                            child: const Text("Add"),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addNewTask() async {
    if (_formKey.currentState!.validate()) {
      final AddNewTaskController addNewTaskController =
          Get.find<AddNewTaskController>();
      final bool result = await addNewTaskController.getAddNewTask(
        _titleTEController.text.trim(),
        _descriptionTEController.text,
      );

      if (result) {
        _autoRefresh = true;
        _clearTextFields();
        if (mounted) {
          showSnackBarMessage(context, "New task added!");
        }
      }
    }
  }

  void _clearTextFields() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
