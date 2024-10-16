import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:real_test/Feature_Settings_Page/Notification.dart';
import 'package:real_test/Controllers/Feature/Gesture_Choice_Controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:real_test/Controllers/Feature/DeviceID_Controller.dart';

class MainSettingsController extends GetxController {
  var functionName = ''.obs;
  var isRegistering = false.obs;
  var irValue = ''.obs;

  final GestureChoiceController gestureController = Get.put(GestureChoiceController()); // GestureChoiceController 인스턴스 참조
  final DeviceController deviceController = Get.put(DeviceController()); // DeviceController 인스턴스 참조

  void setFunctionName(String name) {
    functionName.value = name;
  }

  // 주석 해제된 부분
  void startRegistering(BuildContext context) async {
    isRegistering.value = true;

    bool success = await sendBooleanToServer(true);

    if (success) {
      showRegistrationInProgress(context); // 연결 중 메시지 표시
    } else {
      Get.snackbar('Error', '서버로 boolean 값을 전송하는 데 실패했습니다.');
      isRegistering.value = false;
      return;
    }

    await waitForIrValue(); // 서버 응답을 기다리는 함수 호출

    showRegistrationComplete(context); // 등록 완료 메시지 표시
    Get.snackbar('Success', 'IR 값이 성공적으로 수신되었습니다.');

    isRegistering.value = false; // 연결하기 버튼 활성화
  }

  // 주석 해제된 부분
  Future<bool> sendBooleanToServer(bool value) async {
    final url = Uri.parse(dotenv.env['SEND_BOOLEAN']!);
    try {
      print('Sending boolean value to server: $value'); // 로그 추가
      final response = await http.post(
        url,
        body: {'value': value.toString()},
      );
      print('Server response: ${response.statusCode} - ${response.body}'); // 로그 추가
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 200) {
          irValue.value = responseData['irValue']; // 서버로부터 IR 값 저장
          return true; // 성공 응답 확인
        } else {
          print('Server request failed: ${responseData['message']}');
        }
      } else {
        print('Server request failed: status code ${response.statusCode}');
      }
    } catch (e) {
      print('HTTP 요청 중 오류 발생: $e');
    }
    return false;
  }

  // 주석 해제된 부분
  Future<void> waitForIrValue() async {
    while (irValue.value.isEmpty) {
      print('Waiting for IR value...');
      await Future.delayed(Duration(milliseconds: 500)); // 0.5초 간격으로 대기
    }
  }

  Future<void> saveSettings() async {
    final selectedGesture = gestureController.selectedGesture.value;
    final deviceId = deviceController.deviceid.value; // DeviceID_Controller에서 deviceId 가져오기
    final ir = irValue.value; // 서버에서 받은 IR 값 사용

    if (selectedGesture.isEmpty) {
      Get.snackbar('Error', '제스처를 선택하세요.');
      return;
    }

    if (deviceId.isEmpty) {
      Get.snackbar('Error', 'Device ID가 없습니다.');
      return;
    }

    if (ir.isEmpty) {
      Get.snackbar('Error', 'IR 값이 없습니다.');
      return;
    }

    final url = Uri.parse(dotenv.env['ADD_FEATURE']!);
    try {
      final response = await http.post(
        url,
        body: {
          'deviceId': deviceId, // DeviceID_Controller에서 가져온 deviceId 사용
          'name': functionName.value, // functionName 사용
          'ir': ir, // 서버에서 받은 IR 값 사용
          'gestureId': selectedGesture, // GestureChoiceController에서 가져온 선택된 gestureId 사용
        },
      );
      print('Save settings response: ${response.statusCode} - ${response.body}'); // 로그 추가
      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 201) {
          Get.snackbar('Success', '설정이 성공적으로 저장되었습니다.');
        } else {
          Get.snackbar('Error', '설정을 저장하는 데 실패했습니다.');
        }
      }
    } catch (e) {
      print('HTTP 요청 중 오류 발생: $e');
      Get.snackbar('Error', '서버 요청 중 오류가 발생했습니다.');
    }
  }
}
