import 'package:get/get.dart';

class CameraOverlayController extends GetxController {
  var isRecording = false.obs;

  void startRecording() {
    isRecording.value = true;
  }

  void stopRecording() {
    isRecording.value = false;
  }
}