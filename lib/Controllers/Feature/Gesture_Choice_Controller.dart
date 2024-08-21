import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 패키지 import

class GestureChoiceController extends GetxController {
  var selectedGesture = ''.obs;
  var gestures = <Map<String, dynamic>>[].obs;

  void selectGesture(String gestureName) {
    selectedGesture.value = gestureName;
    print('Gesture selected: $gestureName');
  }

  @override
  void onInit() {
    super.onInit();
    // 페이지에 들어올 때 한 번만 fetchGestures 호출
    fetchGestures();
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
        // 새로운 제스처 데이터를 받기 전에 리스트 초기화
        gestures.clear();

        // multipart 응답 처리
        final boundary = '--' + response.headers['content-type']!.split('boundary=')[1];
        print('Boundary: $boundary');

        final parts = response.body.split(boundary).where((part) => part.isNotEmpty && part != '--').toList();
        print('Number of parts: ${parts.length}');

        for (int i = 0; i < parts.length; i += 2) {
          final gestureDataPart = parts[i];
          final imageDataPart = parts[i + 1];

          if (gestureDataPart.contains('Content-Disposition: form-data; name="gestureData"')) {
            // 제스처 데이터를 파싱
            print('Parsing gesture data part');
            final gestureDataJson = gestureDataPart.split('\r\n\r\n')[1].split('\r\n')[0];
            print('Gesture data JSON: $gestureDataJson');
            final gestureData = jsonDecode(utf8.decode(gestureDataJson.codeUnits));

            if (imageDataPart.contains('Content-Disposition: form-data; name="photo"')) {
              // 이미지 데이터를 처리
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
}
