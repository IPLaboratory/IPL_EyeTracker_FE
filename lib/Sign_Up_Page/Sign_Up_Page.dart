import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_test/Controllers/SignUp/Sign_Up_Controller.dart';
import 'sign_up_page_content.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      init: SignUpController(),
      builder: (signUpController) {
        return const SignUpPageContent(); // context 전달 불필요
      },
    );
  }
}