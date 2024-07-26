import 'package:get/get.dart';

class MainProfileController extends GetxController {
  var isImageVisible = true.obs;
  var isChange = false.obs;
  var chk = 0.obs;

  void addProfile() {
    isImageVisible.value = false;
    chk.value += 1;
  }

  void toggleChange() {
    isChange.value = !isChange.value;
  }
}