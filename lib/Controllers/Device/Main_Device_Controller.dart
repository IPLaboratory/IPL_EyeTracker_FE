import 'package:get/get.dart';

class MainDeviceController extends GetxController {
  void stopEyeTracking() {
    // 아이트래킹 종료 로직 추가
    Get.snackbar(
      '아이트래킹',
      '아이트래킹이 종료되었습니다.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
