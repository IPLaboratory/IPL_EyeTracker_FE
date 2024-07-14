import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/login_provider.dart';
import 'providers/sign_up_provider.dart';
import 'providers/camera_provider.dart';
import 'Main_Page/Main_Page.dart';
import 'Sign_Up_Page/Sign_Up_Page.dart';
import 'Camera_Page/Camera_Page.dart';
import 'User_Registration_Page/User_Registration.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/signup': (context) => SignUpPage(),
        '/camera': (context) => CameraPage(),
        '/user_registration': (context) => UserRegistrationPage(),
      },
    );
  }
}
