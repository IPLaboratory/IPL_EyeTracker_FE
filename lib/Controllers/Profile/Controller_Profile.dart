import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:real_test/Controllers/Profile/Models_Profile.dart';

class ControllerProfile extends GetxController {
  var profiles = <ModelsProfile>[].obs;
  var homeId = 0.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startFetchingProfiles();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
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
      print('Requesting URL: $requestUrl');
      final response = await http.get(requestUrl);

      print('Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        String contentType = response.headers['content-type'] ?? '';
        if (contentType.contains('multipart/form-data')) {
          String boundary = contentType.split("boundary=")[1];
          List<int> bodyBytes = response.bodyBytes;

          // 바운더리로 데이터 분리
          String bodyString = utf8.decode(bodyBytes, allowMalformed: true);
          List<String> parts = bodyString.split("--$boundary");

          // 프로필 리스트 초기화
          List<ModelsProfile> newProfiles = [];

          for (String part in parts) {
            if (part.contains("Content-Disposition")) {
              if (part.contains('name="memberData"')) {
                // JSON 데이터 추출
                String jsonPart = part.split("\r\n\r\n")[1].trim();
                print("JSON Part: $jsonPart");

                // JSON 데이터를 파싱하여 name과 memberId 추출
                var jsonData = jsonDecode(jsonPart);
                String name = jsonData['name'];
                int memberId = jsonData['memberId'];

                // ModelsProfile 객체 생성 및 추가
                ModelsProfile profile = ModelsProfile(
                  id: memberId,
                  name: name,
                  photoPath: null, // 필요시 설정
                  photoBase64: null, // 필요시 설정
                );
                newProfiles.add(profile);

              } else if (part.contains('name="photo"')) {
                // 이미지 데이터 처리
                int headerEndIndex = part.indexOf("\r\n\r\n") + 4;
                List<int> imageBytes = bodyBytes.sublist(
                  bodyBytes.indexOf(10, headerEndIndex) + 1,
                  bodyBytes.length - 2,
                );
                print("Image Data Length: ${imageBytes.length}");

                // 이미지 데이터를 저장하거나 사용할 수 있습니다.
                // 예: File file = File('image.png');
                //     file.writeAsBytesSync(imageBytes);
              }
            }
          }

          // 프로필 리스트 업데이트
          profiles.value = newProfiles;

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
  }

  void _startFetchingProfiles() {
    _timer = Timer.periodic(Duration(seconds: 500), (timer) {
      fetchProfiles();
    });
  }
}
