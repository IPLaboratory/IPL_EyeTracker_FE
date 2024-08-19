import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async'; // dart:async 패키지 추가
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:real_test/Controllers/Profile/Models_Profile.dart';

class ControllerProfile extends GetxController {
  var profiles = <ModelsProfile>[].obs;
  var homeId = 0.obs; // homeId 저장 변수 추가
  Timer? _timer; // Timer 객체 추가

  @override
  void onInit() {
    super.onInit();
    _startFetchingProfiles(); // 타이머 시작
  }

  @override
  void onClose() {
    _timer?.cancel(); // 타이머 취소
    super.onClose();
  }

  void setHomeId(int id) {
    homeId.value = id;
    fetchProfiles(); // homeId 값이 설정되면 프로필 다시 가져오기
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
        String body = utf8.decode(response.bodyBytes);
        Map<String, dynamic> responseData = jsonDecode(body);
        List<dynamic> data = responseData['data'];
        profiles.value = data.map((json) {
          // Null 안전한 방식으로 JSON 파싱
          final memberData = json['member'] ?? {};
          return ModelsProfile(
            id: memberData['id'] as int?,
            name: memberData['name'] as String,
            photoPath: memberData['photoPath'] as String?,
            photoBase64: json['photo'] as String?,
          );
        }).toList();
      } else {
        throw Exception('Failed to load profiles');
      }
    } catch (e) {
      print(e);
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
