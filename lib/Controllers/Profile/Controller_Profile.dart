import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data'; // 바이너리 데이터를 처리하기 위해 추가
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart'; // WidgetsBindingObserver를 사용하기 위해 추가
import 'package:real_test/Controllers/Profile/Models_Profile.dart';

class ControllerProfile extends GetxController with WidgetsBindingObserver {
  var profiles = <ModelsProfile>[].obs; // 전체 프로필 목록을 저장할 Observable 리스트
  var imageBytes = <Rx<Uint8List?>>[].obs; // 이미지 바이너리 데이터를 저장할 리스트
  var homeId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this); // 앱 생명주기 관찰자 추가
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this); // 앱 생명주기 관찰자 제거
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // 앱이 포커스를 얻었을 때 실행되는 코드
      fetchProfiles();
    }
  }

  @override
  void onPageResume() {
    // 페이지로 돌아올 때 데이터 갱신
    fetchProfiles();
  }

  void setHomeId(int id) {
    homeId.value = id;
    fetchProfiles();
  }

  Future<void> fetchProfiles() async {
    final url = dotenv.env['FIND_ALL_MEMBERS_URL'] ?? '';
    if (url.isEmpty) {
      print('FIND_ALL_MEMBERS_URL is not defined in .env file');
      return;
    }

    try {
      final requestUrl = Uri.parse('$url?homeId=${homeId.value}');
      final response = await http.get(requestUrl);

      if (response.statusCode == 200) {
        String contentType = response.headers['content-type'] ?? '';
        if (contentType.contains('multipart/form-data')) {
          String boundary = contentType.split("boundary=")[1];
          List<String> parts = response.body.split("--$boundary");

          profiles.clear();
          imageBytes.clear();

          for (String part in parts) {
            if (part.contains("Content-Disposition")) {
              if (part.contains('name="memberData"')) {
                String jsonPart = part.split("\r\n\r\n")[1].trim();

                // JSON 데이터를 UTF-8로 디코딩
                var jsonData = jsonDecode(utf8.decode(jsonPart.codeUnits));

                String name = jsonData['name'];
                int memberId = jsonData['memberId'];

                ModelsProfile profile = ModelsProfile(
                  id: memberId,
                  name: name,
                );
                profiles.add(profile);
                imageBytes.add(Rx<Uint8List?>(null));

              } else if (part.contains('name="photo"')) {
                int headerEndIndex = part.indexOf("\r\n\r\n") + 4;
                List<int> imageBinaryData = part.substring(headerEndIndex).trim().codeUnits;
                var bytes = Uint8List.fromList(imageBinaryData);

                int imageIndex = profiles.length - 1;
                if (imageIndex >= 0 && imageIndex < imageBytes.length) {
                  imageBytes[imageIndex].value = bytes;
                }
              }
            }
          }

        } else {
          print("Unexpected Content-Type: $contentType");
        }
      } else if (response.statusCode == 400) {
        print('Error 400: 사용자를 찾을 수 없습니다.');
      } else {
        print('Error: Failed to load profiles with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }

  void addProfile(ModelsProfile profile) {
    profiles.add(profile);
    imageBytes.add(Rx<Uint8List?>(null)); // 새 프로필 추가 시 이미지 데이터 리스트도 동기화
  }
}
