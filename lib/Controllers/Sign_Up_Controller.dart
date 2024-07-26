import 'package:get/get.dart';
import '../Profile_Page/Main_Profile.dart'; // MainProfilePage 파일 임포트

class SignUpController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var errorMessage = ''.obs;

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

  void navigateToMainProfilePage() {
    print('navigateToMainProfilePage called');
    print('password: ${password.value}, confirmPassword: ${confirmPassword.value}');

    if (password.value == confirmPassword.value && password.value.isNotEmpty) {
      print('Navigating to MainProfilePage');
      Get.to(() => const MainProfilePage());
    } else {
      validatePasswords();
    }
  }
}
