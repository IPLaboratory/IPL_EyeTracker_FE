import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_test/Color/constants.dart'; // 칼라 임포트
import 'Registration_Part.dart';
import 'Registration_btn.dart';

class UserRegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // 키보드가 올라올 때 화면이 조정되도록 설정
      backgroundColor: AppColors.backgroundColor, // 배경색 설정
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor2, // 배경색 설정
        elevation: 0, // 그림자 제거
        scrolledUnderElevation: 0, // 스크롤 시 그림자 제거
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          // 이전에 'Test_Profile.png'를 사용했던 부분을 제거
          const SizedBox(width: 10), // 약간의 간격 추가
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '등록된 기기',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(color: Colors.grey, thickness: 1), // 등록된 기기 밑에 얇은 회색 선
                    const SizedBox(height: 0), // 간격 조절
                    RegistrationPart(),
                    const SizedBox(height: 20), // 간격 조절
                    RegistrationBtn(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
