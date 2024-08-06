import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:real_test/Controllers/Profile/Models_Profile.dart';

class ControllerProfile extends GetxController {
  var profiles = <ModelsProfile>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfiles();
  }

  Future<void> fetchProfiles() async {
    final url = dotenv.env['FIND_ALL_MEMBERS_URL'] ?? '';
    if (url.isEmpty) {
      print('FIND_ALL_MEMBERS_URL is not defined in .env file');
      return;
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        //List<dynamic> data = jsonDecode(response.body)['data'];
        String body = utf8.decode(response.bodyBytes); // utf8로 디코딩
        List<dynamic> data = jsonDecode(body)['data'];
        profiles.value = data.map((json) => ModelsProfile.fromJson(json)).toList();
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
}