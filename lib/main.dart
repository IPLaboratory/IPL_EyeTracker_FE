import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/login_provider.dart';
import 'providers/sign_up_provider.dart';
import 'providers/camera_provider.dart';
import 'Main_Page/Main_Page.dart';
import 'Sign_Up_Page/Sign_Up_Page.dart';
import 'Camera_Page/Camera_Page.dart';
import 'User_Registration_Page/User_Registration.dart';
import 'Fake_Splash.dart'; // SplashScreen 파일을 임포트

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => CameraProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/splash', // 앱이 처음 시작할 때 스플래시 화면으로 이동
      routes: {
        '/splash': (context) => const SplashScreen(), // 스플래시 화면 경로 설정
        '/': (context) => const HomeScreen(),
        '/signup': (context) => const SignUpPage(),
        '/camera': (context) => const CameraPage(),
        '/user_registration': (context) => const UserRegistrationPage(),
      },
    );
  }
}
