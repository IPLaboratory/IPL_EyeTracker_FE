import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_test/Controllers/Login/Login_Controller.dart';

class LoginForm extends StatelessWidget {
  final FocusNode usernameFocusNode;
  final FocusNode passwordFocusNode;
  final double? fieldWidth;
  final double? fieldHeight;

  const LoginForm({
    required this.usernameFocusNode,
    required this.passwordFocusNode,
    this.fieldWidth,
    this.fieldHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find();

    void _unfocusAll() {
      usernameFocusNode.unfocus();
      passwordFocusNode.unfocus();
    }

    return Column(
      children: [
        SizedBox(
          width: fieldWidth ?? 335,
          height: fieldHeight ?? 50,
          child: TextField(
            focusNode: usernameFocusNode,
            onChanged: (value) => loginController.setUsername(value),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '로그인',
            ),
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(passwordFocusNode);
            },
          ),
        ),
        const SizedBox(height: 17),
        SizedBox(
          width: fieldWidth ?? 335,
          height: fieldHeight ?? 50,
          child: TextField(
            focusNode: passwordFocusNode,
            onChanged: (value) => loginController.setPassword(value),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '비밀번호',
            ),
            obscureText: true,
            onEditingComplete: () {
              _unfocusAll();
            },
          ),
        ),
        Obx(() {
          return loginController.errorMessage.isNotEmpty
              ? Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              loginController.errorMessage.value,
              style: const TextStyle(color: Colors.red),
            ),
          )
              : Container();
        }),
      ],
    );
  }
}
