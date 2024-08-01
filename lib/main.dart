import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 패키지 추가
import 'package:real_test/Main_Page/Widgets/Home_Screen.dart'; // HomeScreen이 정의된 파일
import 'Sign_Up_Page/Sign_Up_Page.dart';
import 'Camera_Page/Camera_Page.dart';
import 'User_Registration_Page/Widget/User_Registration.dart';
import 'Fake_Splash.dart';
import 'Profile_Page/Main_Profile.dart'; // MainProfilePage 임포트
import 'Device_Select_Page/Main_Device.dart'; // MainDevicePage 임포트
import 'User_Registration_Page/Machine_Recognition.dart'; // MachineRecognitionPage 임포트

Future<void> main() async {
  await dotenv.load(fileName: 'assets/.env'); // .env 파일 로드
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
        GetPage(name: '/user_registration', page: () => UserRegistrationPage()),
        GetPage(name: '/mainProfile', page: () => const MainProfilePage()), // MainProfilePage 경로 추가
        GetPage(name: '/mainDevice', page: () => MainDevicePage()), // MainDevicePage 경로 추가
        GetPage(name: '/machineRecognition', page: () => const MachineRecognitionPage()), // MachineRecognitionPage 경로 추가
      ],
    );
  }
}
