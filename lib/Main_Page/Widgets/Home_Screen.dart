import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_test/Dismiss_Keyboard.dart';
import 'package:real_test/Main_Page/Widgets/Title_And_Logo.dart';
import 'package:real_test/Main_Page/Widgets/Login_Form.dart';
import 'package:real_test/Main_Page/Widgets/Login_Button.dart';
import 'package:real_test/Main_Page/Widgets/Sign_Up_Link.dart';
import 'package:real_test/Main_Page/Color/constants.dart';
import 'package:real_test/Controllers/Login/Login_Controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    final usernameFocusNode = FocusNode();
    final passwordFocusNode = FocusNode();

    void _unfocusAll() {
      usernameFocusNode.unfocus();
      passwordFocusNode.unfocus();
    }

    return WillPopScope(
      onWillPop: () async {
        // 앱 종료 확인
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: DismissKeyboard(
          child: GestureDetector(
            onTap: _unfocusAll,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TitleAndLogo(), ////////////이거
                    LoginForm( /////////////이거
                      usernameFocusNode: usernameFocusNode,
                      passwordFocusNode: passwordFocusNode,
                    ),
                    const SizedBox(height: 17),
                    LoginButton(unfocusAll: _unfocusAll), //////////이거
                    SignupLink(unfocusAll: _unfocusAll), ///////////이거
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}