import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:real_test/Controllers/Feature/DeviceID_Controller.dart';

class GestureListPartController extends GetxController {
  var gestures = <Map<String, dynamic>>[].obs;
  final DeviceController deviceController = Get.find<DeviceController>();

  // 서버에서 제스처 목록을 가져오는 함수
  Future<void> fetchGestures() async {
    final deviceId = deviceController.getDeviceID;
    final url = '${dotenv.env['FIND_ALL_FEATURES']}?deviceId=$deviceId';

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
        final parts = response.body.split(boundary).where((part) => part.trim().isNotEmpty && part != '--').toList();
        print('Number of parts: ${parts.length}');

        for (var i = 0; i < parts.length; i++) {
          final part = parts[i];
          print('Processing part: \n$part\n');  // 파트 전체 내용 로그

          if (part.contains('Content-Disposition: form-data; name="featureData"')) {
            print('Parsing gesture data part');
            final gestureDataJson = _extractContent(part);
            print('Extracted gestureDataJson: $gestureDataJson');  // 추출된 JSON 로그

            if (gestureDataJson.isNotEmpty) {
              // UTF-8로 디코딩하여 한글이 깨지지 않도록 처리
              final gestureData = jsonDecode(utf8.decode(gestureDataJson.codeUnits));
              print('Parsed gestureData: $gestureData');  // JSON 파싱된 데이터 로그

              // 다음 파트에서 이미지를 찾음
              if (i + 1 < parts.length) {
                final imagePart = parts[i + 1];
                if (imagePart.contains('Content-Disposition: form-data; name="photo"')) {
                  print('Processing corresponding image part');
                  final imageData = _extractImageData(imagePart);
                  print('Extracted imageData length: ${imageData?.length}');  // 이미지 데이터 길이 로그

                  if (imageData != null) {
                    gestures.add({
                      'name': gestureData['name'],
                      'featureId': gestureData['featureId'],
                      'image': imageData,
                    });
                    print('Gesture added: ${gestureData['name']}');
                  }
                }
              }
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

  String _extractContent(String part) {
    final contentIndex = part.indexOf('\r\n\r\n');
    if (contentIndex != -1) {
      return part.substring(contentIndex + 4).trim();
    }
    print('Failed to extract content from part');
    return '';
  }

  Uint8List? _extractImageData(String part) {
    final contentIndex = part.indexOf('\r\n\r\n');
    if (contentIndex != -1) {
      final imageData = part.substring(contentIndex + 4).trim();
      print('Extracted image data size: ${imageData.length}');  // 추출된 이미지 데이터 길이 로그
      return Uint8List.fromList(imageData.codeUnits);
    }
    print('Failed to extract image data from part');
    return null;
  }
}
