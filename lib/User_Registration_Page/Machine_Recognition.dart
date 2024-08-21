import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_test/Controllers/UserRegistration/Machine_Recogniton_Controller.dart';
import 'package:real_test/Controllers/UserRegistration/User_Registration_Controller.dart'; // UserRegistrationController import
import 'package:real_test/Color/constants.dart';
import 'Already_Device_Part.dart';
import 'Connected_Device_Part.dart';
import 'package:real_test/Dismiss_Keyboard.dart';

class MachineRecognitionPage extends StatefulWidget {
  const MachineRecognitionPage({super.key});

  @override
  _MachineRecognitionPage createState() => _MachineRecognitionPage();
}

class _MachineRecognitionPage extends State<MachineRecognitionPage> {
  @override
  Widget build(BuildContext context) {
    final MachineRecognitionController controller = Get.put(MachineRecognitionController());
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return WillPopScope(
      onWillPop: () async {
        // UserRegistrationPage로 돌아갈 때 갱신 요청을 보냅니다.
        Get.find<UserRegistrationController>().fetchAllDevices();
        return true; // 뒤로 가기 허용
      },
      child: Scaffold(
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
            const SizedBox(width: 5), // 약간의 간격 추가
          ],
        ),
        body: DismissKeyboard(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: isKeyboardVisible
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
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
                        const Divider(
                          color: AppColors.greyLineColor,
                          thickness: 1,
                        ), // 얇은 회색 선 추가
                        const SizedBox(height: 7),
                        // Expanded 대신 SizedBox를 사용하여 크기 제한
                        SizedBox(
                          height: 255, // 적절한 높이를 지정하세요.
                          child: AlreadyDevicePart(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
