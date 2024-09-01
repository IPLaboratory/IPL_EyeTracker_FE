import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StartController extends GetxController {
  // 서버로 POST 요청을 보내는 메서드
  Future<void> startEyeTracking() async {
    final String? url = dotenv.env['START_EYETRACKING'];

    // URL 로드 확인
    print('환경 변수에서 로드된 URL: $url');

    if (url == null || url.isEmpty) {
      print('오류: 환경 변수에서 URL을 찾을 수 없습니다.');
      Get.snackbar('오류', '환경 변수에서 URL을 찾을 수 없습니다.');
      return;
    }

    try {
      print('POST 요청 시작: $url');
      final response = await http.post(Uri.parse(url));
      print('POST 요청 완료. 응답 코드: ${response.statusCode}');

      // 응답 바디를 UTF-8로 디코딩
      final decodedBody = utf8.decode(response.bodyBytes);
      print('UTF-8 디코딩된 응답 바디: $decodedBody');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(decodedBody);
        print('응답 데이터: $responseData');

        if (responseData['status'] == 200) {
          print('성공: ${responseData['message']}');
          Get.snackbar('성공', responseData['message']);
          Get.toNamed('/mainDevice'); // MainDevicePage 경로로 이동
        } else {
          print('오류: 응답 상태 코드가 200이 아닙니다.');
          Get.snackbar('오류', '응답 상태 코드가 200이 아닙니다.');
        }
      } else {
        print('오류: 서버에서 오류가 발생했습니다. 상태 코드: ${response.statusCode}');
        Get.snackbar('오류', '서버에서 오류가 발생했습니다. 상태 코드: ${response.statusCode}');
      }
    } catch (e) {
      print('예외 발생: $e');
      Get.snackbar('오류', '예외가 발생했습니다: $e');
    }
  }
}
