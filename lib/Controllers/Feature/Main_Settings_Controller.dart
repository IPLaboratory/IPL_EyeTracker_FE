import 'package:get/get.dart';

class MainSettingsController extends GetxController {
  var functionName = ''.obs;
  var isRegistering = false.obs;

  void setFunctionName(String name) {
    functionName.value = name;
  }

  void startRegistering() {
    isRegistering.value = true;
  }

  void stopRegistering() {
    isRegistering.value = false;
  }
}
