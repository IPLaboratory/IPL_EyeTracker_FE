import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import '../../Sign_Up_Page/Sign_Up_Page.dart';
//import 'package:animations/animations.dart';
import 'package:real_test/Controllers/Profile/Controller_Profile.dart';

class LoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var errorMessage = ''.obs;
  var homeId = 0.obs; // homeId를 저장할 변수 추가

  void setUsername(String value) {
    username.value = value;
  }

  void setPassword(String value) {
    password.value = value;
  }

  Future<void> login() async {
    final url = dotenv.env['LOGIN_URL'] ?? ''; // .env 파일에서 로그인 URL 가져오기

    if (url.isEmpty) {
      errorMessage.value = '로그인 URL이 설정되지 않았습니다.';
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'name': username.value,
          'password': password.value,
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${utf8.decode(response.bodyBytes)}'); // UTF-8로 디코딩하여 출력

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        if (int.parse(data['status']) == 200) {
          homeId.value = data['data']; // homeId 저장
          print('Home ID: ${homeId.value}');
          Get.snackbar('Success', '홈 로그인 성공!');

          // GetX 컨트롤러 등록
          Get.put(ControllerProfile());
          // ControllerProfile 인스턴스 가져오기
          final controllerProfile = Get.find<ControllerProfile>();
          controllerProfile.setHomeId(homeId.value); // homeId를 ControllerProfile에 설정

          Get.toNamed('/mainProfile'); // 경로 이름 사용
        } else {
          errorMessage.value = data['message'];
        }
      } else if (response.statusCode == 400) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        errorMessage.value = data['message'];
      } else {
        errorMessage.value = '서버 오류가 발생했습니다.';
      }
    } catch (e) {
      errorMessage.value = '네트워크 오류가 발생했습니다. ${e.toString()}';
    }
  }

  void navigateToSignUp(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const SignUpPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}
