import 'package:flutter/material.dart';
import '../Profile_Page/Main_Profile.dart'; // MainProfilePage 파일 임포트

class SignUpProvider with ChangeNotifier {
  String _username = '';
  String _password = '';
  String _confirmPassword = '';
  String _errorMessage = '';

  String get username => _username;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  String get errorMessage => _errorMessage;

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    validatePasswords();
    notifyListeners();
  }

  void validatePasswords() {
    if (_password != _confirmPassword) {
      _errorMessage = '비밀번호가 다릅니다.';
    } else {
      _errorMessage = '';
    }
  }

  void navigateToMainProfilePage(BuildContext context) {
    if (_password == _confirmPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainProfilePage()),
      );
    } else {
      validatePasswords();
      notifyListeners();
    }
  }
}
