import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_test/Controllers/Login/Login_Controller.dart';
import 'package:http/http.dart' as http;
import '../Profile/Controller_Profile.dart';
import 'package:real_test/Profile_Page/Main_Profile.dart';
import 'dart:math'; // dart:math 라이브러리 import 추가

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
    }
  }

  Future<void> uploadImage(int id, String name, String filePath) async {
    if (filePath != null) {
      print("파일 주소: " + filePath);
      final url = dotenv.env['UPDATE_MEMBER_URL'] ?? ''; //.env 파일에서 UPDATE_MEMBER_URL 가져오기

      if (url.isEmpty) {
        Get.snackbar('실패', 'UPDATE_MEMBER_URL이 설정되지 않았습니다.');
        return;
      }

      try {
        // 이미지를 base64로 인코딩
        File imageFile = File(filePath);
        List<int> imageBytes = await imageFile.readAsBytes();
        String base64Image = base64Encode(imageBytes);

        // Base64 문자열의 길이를 기준으로 크기를 계산 (1.5MB 이상인지 확인)
        int base64Length = base64Image.length;
        int maxChunkSize = 2097152; // 1.5MB에 해당하는 약 209만 자

        if (base64Length > maxChunkSize) {
          print('Image is larger than 1.5MB, sending in chunks.');

          int numberOfChunks = (base64Length / maxChunkSize).ceil();
          for (int i = 0; i < numberOfChunks; i++) {
            int start = i * maxChunkSize;
            int end = min(start + maxChunkSize, base64Length); // min 함수 사용
            String chunk = base64Image.substring(start, end);

            var request = http.MultipartRequest('PUT', Uri.parse(url));
            request.fields['id'] = id.toString(); // ID 설정
            request.fields['name'] = name; // 입력된 이름 사용
            request.fields['chunk'] = chunk; // 이미지 청크(Base64로 인코딩된)를 전송
            request.fields['chunkIndex'] = i.toString(); // 현재 청크 인덱스
            request.fields['totalChunks'] = numberOfChunks.toString(); // 총 청크 수

            var response = await request.send();

            if (response.statusCode == 200) {
              var responseData = await http.Response.fromStream(response);
              var responseBody = jsonDecode(responseData.body);
              if (responseBody['status'] == '200') {
                print('Chunk $i sent successfully');
              } else {
                print('Failed to send chunk $i: ${responseBody['message']}');
                return; // 실패 시 전송 중단
              }
            } else {
              print('Failed to send chunk $i');
              return; // 실패 시 전송 중단
            }
          }

          // 모든 청크가 성공적으로 전송된 후 서버가 응답을 처리할 수 있습니다.
          print('Image sent in chunks successfully.');
        } else {
          // 1.5MB 이하라면 한 번에 전송
          var request = http.MultipartRequest('POST', Uri.parse(url));
          request.fields['id'] = id.toString(); // ID 설정
          request.fields['name'] = name; // 입력된 이름 사용
          request.fields['photoBase64'] = base64Image; // Base64로 인코딩된 이미지를 전송

          var response = await request.send();

          if (response.statusCode == 200) {
            var responseData = await http.Response.fromStream(response);
            var responseBody = jsonDecode(responseData.body);
            if (responseBody['status'] == '200') {
              print('Image sent successfully');
              print('Response Data: ${responseBody}');
              Get.snackbar('성공', '프로필 업데이트 성공');
              await profileController.fetchProfiles(); // 데이터 다시 불러오기
              Get.back(); // 페이지 닫기
              Get.off(() => MainProfilePage()); // MainProfilePage로 이동 및 기존 페이지를 대체
            } else {
              print('Failed to send image: ${responseBody['message']}');
              Get.snackbar('실패', responseBody['message'] ?? '프로필 업데이트 실패');
            }
          } else {
            print('Failed to send image');
            Get.snackbar('실패', '프로필 업데이트 실패');
          }
        }
      } catch (e) {
        Get.snackbar('오류', '프로필 업데이트 중 오류가 발생했습니다: $e');
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
