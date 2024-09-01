import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 패키지 import
import 'DeviceID_Controller.dart';  // DeviceID_Controller import
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class GestureChoiceController extends GetxController {
  var selectedGesture = ''.obs;
  var gestures = <Map<String, dynamic>>[].obs;
  var usedGestures = <int>[].obs; // 이미 사용된 제스처 ID를 저장

  void selectGesture(String gestureName) {
    // 제스처 ID가 이미 사용된 경우 중복 선택 방지
    if (usedGestures.contains(int.parse(gestureName))) {
      _showSnackbar("중복된 제스처", "이 제스처는 이미 사용되었습니다. 다른 제스처를 선택해주세요.");
    } else {
      selectedGesture.value = gestureName;
      print('제스처 선택됨: $gestureName');
    }
  }

  void _showSnackbar(String title, String message) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: Colors.transparent,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
        snackStyle: SnackStyle.FLOATING,
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.zero,
        borderRadius: 10,
        messageText: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: ContentType.warning, // 경고 타입으로 설정
        ),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    fetchGestures(); // 제스처 목록 가져오기
    fetchFeatures();  // 기능 전체 조회 호출
  }

  Future<void> fetchGestures() async {
    final url = dotenv.env['FIND_ALL_GESTURES'];  // .env에서 FIND_ALL_GESTURES URL 가져오기
    print('URL from .env: $url');

    if (url == null) {
      print("Error: URL not found in .env file");
      return;
    }

    try {
      print('Sending GET request to $url');
      final response = await http.get(Uri.parse(url));
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        gestures.clear();

        // Content-Type의 boundary 추출
        final boundary = '--' + response.headers['content-type']!.split('boundary=')[1];
        print('Boundary: $boundary');

        // 응답 본문을 boundary로 분할
        final parts = response.body.split(boundary).where((part) => part.isNotEmpty && part != '--').toList();
        print('Number of parts: ${parts.length}');

        for (int i = 0; i < parts.length; i += 2) {
          final gestureDataPart = parts[i];

          // i + 1이 parts 리스트의 범위를 벗어나지 않도록 확인
          if (i + 1 >= parts.length) {
            print("Warning: Parts length is odd or malformed; skipping the last part.");
            break; // parts 길이가 홀수거나 마지막 부분이 잘못된 경우 처리
          }

          final imageDataPart = parts[i + 1];

          if (gestureDataPart.contains('Content-Disposition: form-data; name="gestureData"')) {
            print('Parsing gesture data part');
            final gestureDataJson = gestureDataPart.split('\r\n\r\n')[1].split('\r\n')[0];
            print('Gesture data JSON: $gestureDataJson');
            final gestureData = jsonDecode(utf8.decode(gestureDataJson.codeUnits));

            if (imageDataPart.contains('Content-Disposition: form-data; name="photo"')) {
              print('Processing corresponding image part');
              final imageBinaryData = imageDataPart.split('\r\n\r\n')[1].trim();
              final imageData = Uint8List.fromList(imageBinaryData.codeUnits);
              print('Image binary data length: ${imageData.length}');

              // 제스처 데이터와 이미지를 맵 형태로 저장
              gestures.add({
                'explain': gestureData['explain'],
                'id': gestureData['id'],
                'image': imageData,
              });
              print('Gesture added: ${gestureData['explain']}');
            }
          }
        }
        print('Total gestures loaded: ${gestures.length}');
      } else {
        print('Error: Failed to load gestures. Status code: ${response.statusCode}');
        throw Exception("Failed to load gestures");
      }
    } catch (e) {
      print("Error fetching gestures: $e");
    }
  }

  Future<void> fetchFeatures() async {
    final deviceIdController = Get.find<DeviceController>(); // 올바른 컨트롤러 사용
    final deviceId = deviceIdController.deviceid.value;  // Device ID 가져오기

    final url = dotenv.env['IS_SELECTED'];  // .env에서 FIND_ALL_FEATURES URL 가져오기
    print('URL from .env: $url');

    if (url == null) {
      print("Error: URL not found in .env file");
      return;
    }

    try {
      final response = await http.get(Uri.parse('$url?deviceId=$deviceId'));
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final features = responseData['features'] as List;

        usedGestures.clear();

        for (var feature in features) {
          usedGestures.add(feature['gestureId']);
        }
        print('Used gestures: $usedGestures');
      } else {
        print('Error: Failed to load features. Status code: ${response.statusCode}');
        throw Exception("Failed to load features");
      }
    } catch (e) {
      print("Error fetching features: $e");
    }
  }
}
