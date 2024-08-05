import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_test/Controllers/UserRegistration/Machine_Recogniton_Controller.dart';
import 'package:real_test/Color/constants.dart';
import 'Already_Device_Part.dart';
import 'Connected_Device_Part.dart'; // Controller import
import 'package:real_test/Dismiss_Keyboard.dart'; // DismissKeyboard import

class MachineRecognitionPage extends StatefulWidget {
  const MachineRecognitionPage({super.key});

  @override
  _MachineRecognitionPage createState() => _MachineRecognitionPage();
}

class _MachineRecognitionPage extends State<MachineRecognitionPage> {
  @override
  Widget build(BuildContext context) {
    final MachineRecognitionController controller = Get.put(MachineRecognitionController());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor, // 배경색 설정
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor, // 배경색 설정
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          // 이전에 'Test_Profile.png'를 사용했던 부분을 제거
          const SizedBox(width: 10), // 약간의 간격 추가
        ],
      ),
      body: DismissKeyboard(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConnectedDevicePart(),
                const Text(
                  '등록된 기기',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(color: AppColors.greyLineColor, thickness: 1), // 얇은 회색 선 추가
                const SizedBox(height: 20),
                AlreadyDevicePart(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
