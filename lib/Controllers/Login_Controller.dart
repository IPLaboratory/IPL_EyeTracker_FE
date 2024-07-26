import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_test/Profile_Page/Main_Profile.dart';
import '../User_Registration_Page/User_Registration.dart';
import '../Sign_Up_Page/Sign_Up_Page.dart';

class LoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;

  void setUsername(String value) {
    username.value = value;
  }

  void setPassword(String value) {
    password.value = value;
  }

  void login() {
    // 로그인 로직을 여기에 추가하세요.
    Get.to(() => const MainProfilePage());
  }

  void navigateToSignUp() {
    Get.to(() => const SignUpPage());
  }
}
