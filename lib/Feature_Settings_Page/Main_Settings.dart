import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/Feature/Main_Settings_Controller.dart';
import '../Controllers/Feature/Start_Controller.dart'; // StartController 파일 임포트
import 'Help_Icon.dart';
import 'Gesture_Choice.dart'; // GestureChoice 위젯 임포트
import 'Notification.dart'; // Notification 파일 임포트
import 'package:real_test/Dismiss_Keyboard.dart'; // DismissKeyboard 위젯 임포트

class MainSettingsPage extends StatelessWidget {
  final MainSettingsController controller = Get.put(MainSettingsController());
  final StartController startController = Get.put(StartController()); // StartController 인스턴스 생성

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF9D0), // 배경색 설정
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: const Color(0xFFFFF9D0), // 배경색 설정
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '기능 추가',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(color: Colors.grey, thickness: 1),
                const SizedBox(height: 10), // 간격을 줄였습니다.
                Row(
                  children: [
                    const Text(
                      '기능명 : ',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        onChanged: (value) => controller.setFunctionName(value),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: '기능명을 입력하세요',
                          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0), // 패딩 조정
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10), // 간격을 줄였습니다.
                Row(
                  children: [
                    const Text(
                      'IR 패킷 추가',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        showHelpSnackbar(context); // showHelpSnackbar 호출
                      },
                      child: Image.asset(
                        'assets/Main_Settings_Question.png', // 이미지 경로
                        width: 18,
                        height: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 197, // 버튼 너비 설정
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCAF4FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        onPressed: () {
                          // 연결하기 버튼 기능을 여기에 추가하세요.
                        },
                        child: const Text(
                          '연결하기',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10), // 간격을 줄였습니다.
                const Divider(color: Colors.grey, thickness: 1), // 얇은 회색 선 추가
                const SizedBox(height: 10), // 간격 유지
                const Text(
                  '제스처 선택',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5), // 간격을 줄였습니다.
                SizedBox(
                  height: 300, // 제스처 선택 부분의 높이 설정
                  child: GestureChoice(), // 제스처 선택 부분 추가
                ),
                const SizedBox(height: 20), // 약간의 간격 추가
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFCAF4FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          onPressed: () {
                            controller.saveSettings(); // 저장하기 버튼 기능
                          },
                          child: const Text(
                            '저장하기',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10), // 두 버튼 사이의 간격 추가
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFCAF4FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          onPressed: () {
                            startController.startEyeTracking(); // 시작하기 버튼을 누르면 startEyeTracking 메서드 호출
                          },
                          child: const Text(
                            '시작하기',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
