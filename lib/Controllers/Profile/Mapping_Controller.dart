import 'package:get/get.dart';
import 'package:real_test/Controllers/Profile/Controller_Profile.dart'; // ControllerProfile 임포트
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 임포트
import 'dart:convert';

class MappingController extends GetxController {
  final ControllerProfile profileController = Get.find<ControllerProfile>(); // ControllerProfile 인스턴스 가져오기

  List<Map<String, dynamic>> getMappingData() {
    // profileController에서 매핑 데이터를 가져오는 함수
    print('Fetching mapped profiles from ControllerProfile...');
    List<Map<String, dynamic>> mappedProfiles = profileController.getMappedProfiles();
    print('Mapped profiles fetched: $mappedProfiles');
    printMappedData(mappedProfiles); // 로그로 출력
    return mappedProfiles;
  }

  void printMappedData(List<Map<String, dynamic>> mappedProfiles) {
    // 매핑된 데이터를 로그로 출력
    print('Printing mapped profiles:');
    for (var profile in mappedProfiles) {
      print('Home ID: ${profile['homeId']}, Member ID: ${profile['memberId']}, Name: ${profile['name']}');
    }
  }

  // 서버로 데이터를 보내는 메서드
  Future<void> sendProfileData(int homeId, int memberId, String name) async {
    print('Preparing to send profile data...');
    final url = dotenv.env['SEND_PROFILE_URL'] ?? '';
    if (url.isEmpty) {
      print('SEND_PROFILE_URL is not defined in .env file');
      return;
    }

    // homeId, memberId, memberName을 모두 쿼리 파라미터로 추가
    final uri = Uri.parse('$url?homeId=$homeId&memberId=$memberId&memberName=$name');

    print('Sending profile data to: $uri');

    try {
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        // POST 본문은 비워둠, 모든 데이터는 쿼리 파라미터로 전달
        body: jsonEncode(<String, dynamic>{}),
      );

      print('HTTP status code: ${response.statusCode}');
      print('HTTP response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Profile data sent successfully');
      } else {
        print('Failed to send profile data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while sending profile data: $e');
    }
  }

}
