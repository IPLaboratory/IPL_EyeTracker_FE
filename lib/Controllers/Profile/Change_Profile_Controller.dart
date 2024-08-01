import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 패키지 추가
import 'package:real_test/Controllers/Login/Login_Controller.dart';
// LoginController를 가져오는 경로는 실제 경로에 맞게 수정하세요

/*class ProfileController extends GetxController {
  var selectedImage = Rx<XFile?>(null);
  final ImagePicker _picker = ImagePicker();

  Future<void> getImage(ImageSource imageSource) async {
    final XFile? selectImage = await _picker.pickImage(
      source: imageSource,
    );

    if (selectImage != null) {
      selectedImage.value = selectImage;
      await uploadImage(selectImage.path);
    }
  }
}*/


class ProfileController extends GetxController {
  var selectedImage = Rx<XFile?>(null);
  final ImagePicker _picker = ImagePicker();
  final LoginController loginController = Get.find(); // LoginController 인스턴스 가져오기
  final TextEditingController nameController = TextEditingController();

  Future<void> getImage(ImageSource imageSource) async {
    final XFile? selectImage = await _picker.pickImage(
      source: imageSource,
    );

    if (selectImage != null) {
      selectedImage.value = selectImage;
      await uploadImage(selectImage.path);
    }
  }

  Future<void> uploadImage(String filePath) async {
    if(filePath != null){
      final url = dotenv.env['ADD_MEMBER_URL'] ?? ''; //.env 파일에서 ADD_MEMVER_URL 가져오기

      if(url.isEmpty){
        Get.snackbar('실패', 'ADD_MEMBER_URL이 설정되지 않았습니다.');
        return;
      }
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      request.fields['homeId'] = loginController.homeId.value.toString(); // homeId를 롱 값으로 전송
      request.fields['name'] = nameController.text;
      request.files.add(await http.MultipartFile.fromPath('jpg', filePath));

      var response = await request.send();
      if (response.statusCode == 200) {
        Get.snackbar('성공', '사진 업로드 성공');
        Get.toNamed('/mainProfile'); // 경로 이름 사용
      } else {
        var responseData = await http.Response.fromStream(response);
        var responseBody = jsonDecode(responseData.body);
        Get.snackbar('실패', responseBody['message'] ?? '사진 업로드 실패');
      }
    }
  }
}
