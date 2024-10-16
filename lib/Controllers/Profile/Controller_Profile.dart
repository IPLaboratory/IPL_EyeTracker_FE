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

  // 새로운 변수: 매핑된 데이터를 저장할 리스트
  var mappedProfiles = <Map<String, dynamic>>[].obs;

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

  // 매핑된 데이터를 추출하는 함수 추가
  List<Map<String, dynamic>> getMappedProfiles() {
    return mappedProfiles.toList(); // 저장된 매핑 데이터 리스트 반환
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
          mappedProfiles.clear(); // 이전에 저장된 매핑 데이터 초기화

          // 홈 아이디 별로 멤버들을 저장할 Map
          Map<int, List<ModelsProfile>> groupedProfiles = {};

          for (String part in parts) {
            if (part.contains("Content-Disposition")) {
              if (part.contains('name="memberData"')) {
                String jsonPart = part.split("\r\n\r\n")[1].trim();

                // JSON 데이터를 UTF-8로 디코딩
                var jsonData = jsonDecode(utf8.decode(jsonPart.codeUnits));

                String name = jsonData['name'];
                int memberId = jsonData['memberId'];
                int homeIdFromServer = homeId.value; // 서버에서 가져온 homeId

                ModelsProfile profile = ModelsProfile(
                  id: memberId,
                  name: name,
                );

                // 홈 아이디별로 멤버를 그룹화
                if (!groupedProfiles.containsKey(homeIdFromServer)) {
                  groupedProfiles[homeIdFromServer] = [];
                }
                groupedProfiles[homeIdFromServer]!.add(profile);

                // 멤버 아이디 로그 출력
                print('Member ID: $memberId, Name: $name, Home ID: $homeIdFromServer');
              }
            }
          }

          // 그룹별로 멤버 아이디 정렬 후 프로필 매핑
          groupedProfiles.forEach((homeIdKey, memberList) {
            memberList.sort((a, b) => a.id.compareTo(b.id)); // 멤버 아이디로 정렬

            for (var i = 0; i < memberList.length; i++) {
              final profile = memberList[i];
              // 매핑된 결과 로그 출력
              print('Mapped Profile: Home ID: $homeIdKey, Profile ${i + 1}: Member ID: ${profile.id}, Name: ${profile.name}');

              // 매핑된 데이터 저장
              mappedProfiles.add({
                'homeId': homeIdKey,
                'profileIndex': i + 1,
                'memberId': profile.id,
                'name': profile.name,
              });

              profiles.add(profile);
              imageBytes.add(Rx<Uint8List?>(null)); // 빈 이미지 추가
            }
          });

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
