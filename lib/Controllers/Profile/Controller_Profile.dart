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
    //fetchProfiles();
    _startFetchingProfiles(); // 타이머 시작
  }

  @override
  void onClose() {
    _timer?.cancel(); // 타이머 취소
    super.onClose();
  }

  void setHomeId(int id) {
    homeId.value = id;
    print('HOME: ${homeId.value}');
    fetchProfiles(); // homeId 값이 설정되면 프로필 다시 가져오기
  }

  Future<void> fetchProfiles() async {
    final url = dotenv.env['FIND_ALL_MEMBERS_URL'] ?? '';
    if (url.isEmpty) {
      print('FIND_ALL_MEMBERS_URL is not defined in .env file');
      return;
    }

    try {
      // URL에 homeId 값을 쿼리 매개변수로 추가
      final requestUrl = Uri.parse('$url?homeId=${homeId.value}');
      final response = await http.get(requestUrl);
      print(requestUrl);

      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes); // utf8로 디코딩
        Map<String, dynamic> responseData = jsonDecode(body);
        // 응답 데이터에서 'data' 키로 프로필 데이터를 추출
        List<dynamic> data = responseData['data'];
        // 모델 인스턴스를 생성하여 프로필 리스트 업데이트
        profiles.value = data.map((json) => ModelsProfile.fromJson(json)).toList();
        print(profiles.value);
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
    //나중에 시현할때는 3으로 바꿔주기
    _timer = Timer.periodic(Duration(seconds: 500), (timer) {
      fetchProfiles();
    });
  }
}
