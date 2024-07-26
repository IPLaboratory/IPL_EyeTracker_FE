import 'package:get/get.dart';

class GestureChoiceController extends GetxController {
  var selectedGesture = ''.obs;

  void selectGesture(String gestureName) {
    selectedGesture.value = gestureName;
  }
}
