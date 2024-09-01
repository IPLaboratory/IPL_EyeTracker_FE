import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MainDeviceController extends GetxController {
  void stopEyeTracking() async {
    try {
      // 로그: 서버 URL 가져오기
      print('로그: 서버 URL 가져오기');
      final url = dotenv.env['CLOSE_EYETRACKING']!;
      print('로그: 서버 URL = $url');

      // 로그: POST 요청 보내기 시작
      print('로그: POST 요청 보내기 시작');
      final response = await http.post(Uri.parse(url));

      // 로그: 응답 상태 코드 확인
      print('로그: 응답 상태 코드 = ${response.statusCode}');

      if (response.statusCode == 200) {
        // 응답 데이터 UTF-8로 디코딩 후 JSON 파싱
        final responseData = json.decode(utf8.decode(response.bodyBytes));

        // 로그: 응답 데이터 확인
        print('로그: 응답 데이터 = $responseData');

        if (responseData['status'] == 200) {
          Get.snackbar(
            '아이트래킹',
            responseData['message'],
            snackPosition: SnackPosition.BOTTOM,
          );
          // 로그: 성공 시 /mainProfile로 이동
          print('로그: 성공, /mainProfile로 이동');
          Get.toNamed('/mainProfile');
        } else {
          // 로그: 서버에서 오류 발생
          print('로그: 서버에서 오류 발생, 메시지 = ${responseData['message']}');
          Get.snackbar(
            '오류',
            '서버에서 오류가 발생했습니다.',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        // 로그: 서버 요청 실패
        print('로그: 서버 요청 실패, 상태 코드 = ${response.statusCode}');
        Get.snackbar(
          '오류',
          '서버 요청에 실패했습니다.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      // 로그: 예기치 못한 오류 발생
      print('로그: 예기치 못한 오류 발생, 에러 = $e');
      Get.snackbar(
        '오류',
        '아이트래킹 종료 중 예기치 못한 오류가 발생했습니다.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
