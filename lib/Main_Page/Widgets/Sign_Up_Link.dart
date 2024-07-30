import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_test/Main_Page/Color/constants.dart';
import 'package:real_test/Controllers/Login/Login_Controller.dart';

class SignupLink extends StatelessWidget {
  final VoidCallback unfocusAll;

  const SignupLink({super.key, required this.unfocusAll});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find();

    return Column(
      children: [
        const SizedBox(height: 10),
        const Text(
          'E.T.의 회원이 아니신가요?',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.greyTextColor,
          ),
        ),
        GestureDetector(
          onTap: () {
            unfocusAll();
            loginController.navigateToSignUp(context); // BuildContext 전달
          },
          child: const Text(
            '지금 가입하세요.',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.linkColor,
            ),
          ),
        ),
      ],
    );
  }
}
