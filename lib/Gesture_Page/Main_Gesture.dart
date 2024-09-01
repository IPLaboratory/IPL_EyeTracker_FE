import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_test/Color/constants.dart';
import 'package:real_test/Profile_Page/Main_Profile.dart';
import 'package:real_test/Feature_Settings_Page/Main_Settings.dart';
import 'Gesture_List_Part.dart';
import 'package:real_test/Controllers/Feature/DeviceID_Controller.dart'; // DeviceController import
import 'package:real_test/Controllers/Gesture/Gesture_List_Part_Controller.dart'; // GestureListPartController import

class MainGesturePage extends StatefulWidget {
  final String? photoPath;  // 이미지 경로를 받는 매개변수
  final String title;  // title을 받는 매개변수
  final String deviceID;  // deviceID를 받는 매개변수 추가

  const MainGesturePage({
    super.key,
    this.photoPath,
    required this.title,
    required this.deviceID,  // 필수 매개변수로 선언
  });

  @override
  _MainGesturePageState createState() => _MainGesturePageState();
}

class _MainGesturePageState extends State<MainGesturePage> {
  final DeviceController deviceController = Get.put(DeviceController()); // DeviceController 인스턴스 생성
  final GestureListPartController gestureListPartController = Get.put(GestureListPartController()); // GestureListPartController 인스턴스 생성

  @override
  void initState() {
    super.initState();
    // deviceID를 DeviceController에 저장
    deviceController.setDeviceID(widget.deviceID);
    // 제스처 목록을 초기화하는 코드 추가 (필요한 경우)
    gestureListPartController.fetchGestures();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        actions: [
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Center(
              child: Text(
                '현재 연결된 기기입니다. 원하는 기능을 이용하세요.',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: SizedBox(
                  width: 140,
                  height: 140,
                  child: widget.photoPath != null
                      ? Image.network(widget.photoPath!)
                      : Image.asset(
                    'assets/기본사물.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            AdjustableText(
              text: widget.title,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '기능 목록',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCAF4FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainSettingsPage()),
                      );
                    },
                    child: const Text(
                      '기능 선택하러 가기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.textColor, thickness: 1),
            const SizedBox(height: 20),
            GestureListPart(), // GestureListPart를 렌더링
          ],
        ),
      ),
    );
  }
}
