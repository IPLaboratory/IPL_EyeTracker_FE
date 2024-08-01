import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_test/Color/constants.dart';
import 'package:real_test/Controllers/UserRegistration/Machine_Recogniton_Controller.dart'; // Controller import
import 'package:real_test/Feature_Settings_Page/Main_Settings.dart';

class ConnectedDevicePart extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final MachineRecognitionController controller = Get.put(MachineRecognitionController());

    return Column(
      children: [
        const Text(
          '기기 등록',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(color: AppColors.greyLineColor, thickness: 1), // 얇은 회색 선 추가
        const SizedBox(height: 10), // 회색선과 텍스트 사이 간격 조절
        const Center( // 중앙 정렬을 위해 Center 위젯 사용
          child: Text(
            '현재 접속한 기기를 등록할까요?',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 10), // 회색선과 텍스트 사이 간격 조절
        const Divider(color: AppColors.greyLineColor, thickness: 1), // 텍스트 밑에 얇은 회색 선 추가
        const SizedBox(height: 20),
        Row(
          children: [
            Image.asset(
              'assets/Hot_Light.jpg', // 현재 기기 이미지 경로
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 10),
            Obx(() => Text(
              '현재 접속 기기: ${controller.currentDevice.value}', // 현재 접속된 기기 정보
              style: TextStyle(
                fontSize: 18,
              ),
            )),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
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
              '기능 설정',
              style: TextStyle(
              fontSize: 18,
              color: AppColors.textColor,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Divider(color: AppColors.greyLineColor, thickness: 1), // 얇은 회색 선 추가
      ],
    );
  }
}