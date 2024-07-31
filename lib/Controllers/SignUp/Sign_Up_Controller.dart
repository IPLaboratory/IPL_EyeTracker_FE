import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SignUpController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var errorMessage = ''.obs;
  var homeId = 0.obs; // homeId를 저장할 변수 추가

  void setUsername(String value) {
    username.value = value;
  }

  void setPassword(String value) {
    password.value = value;
    validatePasswords();
  }

  void setConfirmPassword(String value) {
    confirmPassword.value = value;
    validatePasswords();
  }

  void validatePasswords() {
    if (password.value != confirmPassword.value) {
      errorMessage.value = '비밀번호가 다릅니다.';
    } else {
      errorMessage.value = '';
    }
  }

  Future<void> signUp() async {
    if (password.value != confirmPassword.value || password.value.isEmpty) {
      validatePasswords();
      return;
    }

    final url = dotenv.env['SIGN_UP_URL'] ?? ''; // 환경 변수에서 URL 가져오기

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': username.value,
          'password': password.value,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${utf8.decode(response.bodyBytes)}'); // UTF-8로 디코딩하여 출력

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes)); // 응답 본문을 UTF-8로 디코딩하여 JSON 파싱
        if (int.parse(data['status']) == 200) {
          // 회원가입 성공 시
          homeId.value = data['data']['id']; // homeId 저장
          print('Home ID: ${homeId.value}');
          print('Navigating to MainProfilePage');
          Get.toNamed('/mainProfile'); // 경로 이름 사용
          print('Navigated to MainProfilePage');
        } else {
          // 서버가 반환한 메시지를 에러 메시지로 설정
          errorMessage.value = data['message'];
        }
      } else if (response.statusCode == 400) {
        // 잘못된 요청에 대한 처리
        final data = json.decode(utf8.decode(response.bodyBytes)); // 응답 본문을 UTF-8로 디코딩하여 JSON 파싱
        errorMessage.value = data['message']; // 서버가 반환한 메시지를 에러 메시지로 설정
      } else {
        // 기타 서버 오류 처리
        errorMessage.value = '서버 오류가 발생했습니다.';
      }
    } catch (e) {
      // 네트워크 오류 처리
      errorMessage.value = '네트워크 오류가 발생했습니다. ${e.toString()}';
    }
  }

  void navigateToMainProfilePage() {
    print('navigateToMainProfilePage called');
    print('password: ${password.value}, confirmPassword: ${confirmPassword.value}');

    if (password.value == confirmPassword.value && password.value.isNotEmpty) {
      signUp();
    } else {
      validatePasswords();
    }
  }
}
