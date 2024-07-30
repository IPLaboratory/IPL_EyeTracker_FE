import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_test/Main_Page/Color/constants.dart';
import 'package:real_test/Controllers/Login/Login_Controller.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback unfocusAll;
  final double? width;
  final double? height;

  const LoginButton({super.key, required this.unfocusAll, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find();

    return SizedBox(
      width: width ?? 335, // 기본 너비를 335으로 설정
      height: height ?? 50, // 기본 높이를 50으로 설정
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        onPressed: () async {
          unfocusAll();
          await loginController.login(); // 로그인 로직 호출
        },
        child: const Text(
          '로그인',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
        ),
      ),
    );
  }
}
