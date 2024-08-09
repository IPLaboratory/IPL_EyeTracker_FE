import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 패키지 추가
import 'package:real_test/Controllers/Login/Login_Controller.dart'; // LoginController를 가져오는 경로는 실제 경로에 맞게 수정하세요

class UserRegistrationController extends GetxController with GetTickerProviderStateMixin {
  final List<TextEditingController> nameControllers = List.generate(3, (_) => TextEditingController());
  final List<TextEditingController> descriptionControllers = List.generate(3, (_) => TextEditingController());
  final List<RxString> imagePaths = List.generate(3, (_) => 'assets/Camera_Test.png'.obs);

  final LoginController loginController = Get.find(); // LoginController 인스턴스 참조
  var devices = [].obs; // 전체 기기 목록을 저장할 Observable 리스트

  @override
  void onInit() {
    super.onInit();
    // 초기 설정 및 필요한 데이터 로드
  }

  @override
  void onReady() {
    super.onReady();
    // fetchAllDevices() 호출 제거
  }

  @override
  void onPageResume() {
    // 페이지로 돌아올 때 데이터 갱신
    fetchAllDevices();
  }

  void updateImagePath(int index, String path) {
    imagePaths[index].value = path;
  }

  Future<void> fetchAllDevices() async {
    print('fetchAllDevices 호출됨: 갱신 시작'); // 갱신 시작 시 로그 출력

    final String? url = dotenv.env['FIND_ALL_DEVICES']; // .env 파일에서 FIND_ALL_DEVICES_URL 가져오기

    if (url == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar('Error', 'FIND_ALL_DEVICES_URL이 설정되지 않았습니다.');
      });
      return;
    }

    final homeId = loginController.homeId.value;
    print('homeId: $homeId'); // homeId 로그 출력
    final requestUrl = '$url?homeId=$homeId';
    print('Request URL: $requestUrl'); // 요청 URL 로그 출력

    try {
      final response = await http.get(Uri.parse(requestUrl));
      final responseBody = utf8.decode(response.bodyBytes); // UTF-8 디코딩

      print('서버 응답: ${response.statusCode} - $responseBody'); // 서버 응답 로그 출력

      if (response.statusCode == 200) {
        var responseData = jsonDecode(responseBody);
        devices.value = responseData['data']; // 전체 기기 목록 업데이트
        print('전체 기기 조회 성공: ${devices.length}개의 기기가 로드되었습니다.');
      } else if (response.statusCode == 400) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.snackbar('Error', '홈을 찾을 수 없습니다.');
        });
        print('홈을 찾을 수 없습니다.');
      } else {
        var responseData = jsonDecode(responseBody);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.snackbar('Error', responseData['message'] ?? '전체 기기 조회 실패');
        });
        print('전체 기기 조회 실패: ${responseData['message']}');
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar('Error', '전체 기기 조회 중 오류 발생: $e');
      });
      print('전체 기기 조회 중 오류 발생: $e');
    }

    print('fetchAllDevices 완료됨: 갱신 종료'); // 갱신 종료 시 로그 출력
  }

  @override
  void onClose() {
    for (var controller in nameControllers) {
      controller.dispose();
    }
    for (var controller in descriptionControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
