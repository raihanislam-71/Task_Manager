import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controllers/email_varification_controller.dart';
import 'package:task_manager_app/ui/screens/auth/pin_varification_screen.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';

import '../../utility/app_colors.dart';
import '../../widgets/background_widget.dart';

class EmailVarificationScreen extends StatefulWidget {
  const EmailVarificationScreen({super.key});

  @override
  State<EmailVarificationScreen> createState() =>
      _EmailVarificationScreenState();
}

class _EmailVarificationScreenState extends State<EmailVarificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    'Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'A 6 digits varification pin will be sent to your email address',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<EmailVarificationController>(
                    builder: (emailVarificationController) {
                      return Visibility(
                        visible: emailVarificationController.emailVarificationInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: _onTapConfirmButton,
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      );
                    }
                  ),
                  const SizedBox(height: 36),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                        ),
                        text: "Have account? ",
                        children: [
                          TextSpan(
                            text: 'Sign up',
                            style: TextStyle(color: AppColors.themeColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSingInButton,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSingInButton() {
    Navigator.pop(context);
  }

  Future<void> _onTapConfirmButton() async {
    if (_emailTEController.text.trim().isNotEmpty) {
      final EmailVarificationController emailVarificationController = Get.find<EmailVarificationController>();
      final bool result = await emailVarificationController.emailVarification(_emailTEController.text.trim());

      if(result){
        Get.to(() => PinVarificationScreen(email: _emailTEController.text.trim()));
      }else{
        if(mounted){
          showSnackBarMessage(context, emailVarificationController.errorMassage);
        }
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
