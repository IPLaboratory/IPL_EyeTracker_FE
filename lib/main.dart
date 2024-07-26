import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Main_Page/Main_Page.dart'; // HomeScreen이 정의된 파일
import 'Sign_Up_Page/Sign_Up_Page.dart';
import 'Camera_Page/Camera_Page.dart';
import 'User_Registration_Page/User_Registration.dart';
import 'Fake_Splash.dart';
import 'Profile_Page/Main_Profile.dart'; // MainProfilePage 임포트

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Maple', // 전역 폰트 설정
      ),
      initialRoute: '/splash', // 앱이 처음 시작할 때 스플래시 화면으로 이동
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()), // HomeScreen 경로 설정
        GetPage(name: '/signup', page: () => const SignUpPage()),
        GetPage(name: '/camera', page: () => CameraPage(onProfileAdded: () {
          // 프로필 추가 로직
        })),
        GetPage(name: '/user_registration', page: () => const UserRegistrationPage()),
        GetPage(name: '/mainProfile', page: () => const MainProfilePage()), // MainProfilePage 경로 추가
      ],
    );
  }
}
