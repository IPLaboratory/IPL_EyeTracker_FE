import 'package:flutter/material.dart';
import '../Profile_Page/Main_Profile.dart'; // Main_Profile 페이지를 import
import '../Sign_Up_Page/Sign_Up_Page.dart';

class LoginProvider with ChangeNotifier {
  String _username = '';
  String _password = '';

  String get username => _username;
  String get password => _password;

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void login(BuildContext context) {
    // 로그인 로직을 여기에 추가하세요.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MainProfilePage()),
    );
  }

  void navigateToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpPage()),
    );
  }
}
