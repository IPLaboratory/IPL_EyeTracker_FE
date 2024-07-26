import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRegistrationController extends GetxController {
  final List<TextEditingController> nameControllers = List.generate(3, (_) => TextEditingController());
  final List<TextEditingController> descriptionControllers = List.generate(3, (_) => TextEditingController());
  final List<RxString> imagePaths = List.generate(3, (_) => 'assets/Camera_Test.png'.obs);

  void updateImagePath(int index, String path) {
    imagePaths[index].value = path;
  }

  @override
  void dispose() {
    for (var controller in nameControllers) {
      controller.dispose();
    }
    for (var controller in descriptionControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
