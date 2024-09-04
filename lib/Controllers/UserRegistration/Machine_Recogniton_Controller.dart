import 'package:get/get.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:real_test/Controllers/Login/Login_Controller.dart';
import 'dart:convert';

class MachineRecognitionController extends GetxController {
  RxString currentDevice = ''.obs;
  RxList<Device> registeredDevices = <Device>[].obs; // 빈 리스트로 초기화

  final LoginController loginController = Get.find(); // LoginController 인스턴스 가져오기
  RxString deviceId = ''.obs; // Device ID를 저장할 변수 추가

  // 기기를 등록 목록에 추가하는 메서드
  void registerDevice(String deviceName, String imagePath) {
    registeredDevices.add(Device(name: deviceName, description: '', imagePath: imagePath));
  }

  // 등록된 기기의 이미지를 업데이트하는 메서드
  void updateDeviceImage(String deviceName, String newImagePath) {
    for (var device in registeredDevices) {
      if (device.name == deviceName) {
        device.imagePath = newImagePath;
        registeredDevices.refresh();
        break;
      }
    }
  }

  // 서버로 기기를 등록하는 메서드 (성공 시 true, 실패 시 false 반환)
  Future<bool> sendDeviceToServer(String deviceName, File imageFile) async {
    final String? serverUrl = dotenv.env['ADD_DEVICE']; // 환경변수에서 서버 URL 가져오기
    if (serverUrl == null) {
      print('Server URL not found in .env file');
      return false;
    }

    try {
      var request = http.MultipartRequest('POST', Uri.parse(serverUrl));
      request.fields['homeId'] = loginController.homeId.value.toString(); // homeId를 전송
      request.fields['name'] = deviceName; // 기기 이름을 전송
      request.files.add(await http.MultipartFile.fromPath('photo', imageFile.path)); // 사진 파일 전송

      var response = await request.send();

      // 서버 응답이 성공적일 때
      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var responseBody = jsonDecode(responseData.body);

        // 서버에서 반환된 데이터가 성공일 때
        if (responseBody['status'] == '200') {
          deviceId.value = responseBody['data']['id'].toString(); // Device ID 저장
          print('Device registered successfully');
          return true;
        } else {
          print('Failed to register device: ${responseBody['message']}');
          return false;
        }
      } else {
        print('Failed to register device: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // 예외 처리 (서버 연결 오류 등)
      print('Error occurred while registering device: $e');
      return false;
    }
  }
}

// Device 클래스: 등록된 기기 정보를 담는 데이터 모델
class Device {
  String name;
  String description;
  String imagePath;

  Device({
    required this.name,
    required this.description,
    required this.imagePath,
  });
}
