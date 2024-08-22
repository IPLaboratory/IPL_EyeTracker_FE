import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_test/Controllers/Login/Login_Controller.dart';
import 'package:http_parser/http_parser.dart';  // http_parser 패키지 추가
import 'package:http/http.dart' as http;
import '../Profile/Controller_Profile.dart';
import 'package:real_test/Profile_Page/Main_Profile.dart';


class ProfileController extends GetxController {
  var selectedImage = Rx<XFile?>(null);
  final ImagePicker _picker = ImagePicker();
  final LoginController loginController = Get.find(); // LoginController 인스턴스 가져오기
  final TextEditingController nameController = TextEditingController();
  final ControllerProfile profileController = Get.find<ControllerProfile>(); // ControllerProfile 인스턴스 가져오기
  Future<void> getImage(ImageSource imageSource) async {
    final XFile? selectImage = await _picker.pickImage(
      source: imageSource,
    );
    if (selectImage != null) {
      selectedImage.value = selectImage;
      //await uploadImage(selectImage.path);
    }
  }
  Future<void> uploadImage(int id, String name, String filePath) async {
    if(filePath != null){
      print("파일 주소: " + filePath);
      final url = dotenv.env['UPDATE_MEMBER_URL'] ?? ''; //.env 파일에서 UPDATE_MEMBER_URL 가져오기
      if(url.isEmpty){
        Get.snackbar('실패', 'UPDATE_MEMBER_URL이 설정되지 않았습니다.');
        return;
      }
      var request = http.MultipartRequest('PUT', Uri.parse(url));
      // 사용자 ID
      request.fields['id'] = id.toString(); // ID 설정
      // 새로운 사용자 이름
      request.fields['name'] = name; // 입력된 이름 사용
      //새로운 사진 파일
      //request.files.add(await http.MultipartFile.fromPath('jpg', filePath));
      request.files.add(await http.MultipartFile.fromPath(
          'photo',
          filePath,
          contentType: MediaType('image', 'jpeg')  // 적절한 MIME 타입 설정
      ));

      try {
        var response = await request.send();
        if (response.statusCode == 200) {
          Get.snackbar('성공', '사진 업로드 성공');
          await profileController.fetchProfiles(); // 데이터 다시 불러오기
          Get.back(); // 페이지 닫기
          // 기존 페이지를 닫고 MainProfilePage로 이동
          Get.off(() => MainProfilePage()); // MainProfilePage로 이동 및 기존 페이지를 대체
          //Get.toNamed('/mainProfile'); // 경로 이름 사용
        } else {
          var responseData = await http.Response.fromStream(response);
          var responseBody = jsonDecode(responseData.body);
          Get.snackbar('실패', responseBody['message'] ?? '사진 업로드 실패');
        }
      } catch (e) {
        Get.snackbar('오류', '사진 업로드 중 오류가 발생했습니다: $e');
      }
    }
  }

  Future<void> uploadjustname(int id, String name) async {
    final url = dotenv.env['UPDATE_MEMBER_URL'] ?? ''; //.env 파일에서 UPDATE_MEMBER_URL 가져오기

    if (url.isEmpty) {
      Get.snackbar('실패', 'UPDATE_MEMBER_URL이 설정되지 않았습니다.');
      return;
    }

    var request = http.Request('PUT', Uri.parse(url));

    // 사용자 ID와 이름을 폼 데이터로 추가
    request.bodyFields = {
      'id': id.toString(),
      'name': name,
    };

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        Get.snackbar('성공', '데이터 업로드 성공');
        await profileController.fetchProfiles(); // 데이터 다시 불러오기
        Get.back(); // 페이지 닫기
        Get.off(() => MainProfilePage()); // MainProfilePage로 이동 및 기존 페이지를 대체
      } else {
        var responseData = await http.Response.fromStream(response);
        var responseBody = jsonDecode(responseData.body);
        Get.snackbar('실패', responseBody['message'] ?? '데이터 업로드 실패');
      }
    } catch (e) {
      Get.snackbar('오류', '데이터 업로드 중 오류가 발생했습니다: $e');
    }
  }
}