import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data'; // 바이너리 데이터를 처리하기 위해 추가
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 패키지 추가
import 'package:real_test/Controllers/Login/Login_Controller.dart'; // LoginController를 가져오는 경로는 실제 경로에 맞게 수정하세요

class UserRegistrationController extends GetxController with GetTickerProviderStateMixin {
  final List<TextEditingController> nameControllers = List.generate(3, (_) => TextEditingController());
  final List<TextEditingController> descriptionControllers = List.generate(3, (_) => TextEditingController());
  var imageBytes = <Rx<Uint8List?>>[].obs; // 이미지 바이너리 데이터를 저장할 리스트

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

  Future<void> fetchAllDevices() async {
    print('fetchAllDevices 호출됨: 갱신 시작'); // 갱신 시작 시 로그 출력

    // 기존 데이터를 초기화
    devices.clear();
    imageBytes.clear(); // imageBytes도 초기화

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
      print('서버 응답 상태 코드: ${response.statusCode}'); // 상태 코드 로그 출력

      if (response.statusCode == 200) {
        final boundary = response.headers['content-type']?.split('boundary=')?.last;
        if (boundary != null) {
          var parts = response.body.split('--$boundary');
          for (var part in parts) {
            if (part.contains('Content-Disposition: form-data; name="deviceData"')) {
              // JSON 데이터를 파싱
              var deviceDataJson = part.split('\r\n\r\n')[1].split('\r\n')[0];

              // UTF-8로 디코딩하여 문자열 처리
              var deviceData = jsonDecode(utf8.decode(deviceDataJson.codeUnits));
              devices.add({
                'name': deviceData['name'],
                'id': deviceData['deviceId'],
              });

              // imageBytes에 null 추가하여 리스트 길이 동기화
              imageBytes.add(Rx<Uint8List?>(null));
            } else if (part.contains('Content-Disposition: form-data; name="photo"')) {
              // 이미지 바이너리 데이터를 처리
              var imageIndex = devices.length - 1; // 마지막 추가된 기기의 이미지와 매칭
              var imageBinaryData = part.split('\r\n\r\n')[1].trim().codeUnits;
              var bytes = Uint8List.fromList(imageBinaryData);
              if (imageIndex >= 0 && imageIndex < imageBytes.length) {
                imageBytes[imageIndex].value = bytes;
              }
            }
          }
          print('전체 기기 조회 성공: ${devices.length}개의 기기가 로드되었습니다.');
        }
      } else if (response.statusCode == 400) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.snackbar('Error', '홈을 찾을 수 없습니다.');
        });
        print('홈을 찾을 수 없습니다.');
      } else {
        var responseData = jsonDecode(response.body);
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
