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

  void registerDevice(String deviceName, String imagePath) {
    registeredDevices.add(Device(name: deviceName, description: '', imagePath: imagePath));
  }

  void updateDeviceImage(String deviceName, String newImagePath) {
    for (var device in registeredDevices) {
      if (device.name == deviceName) {
        device.imagePath = newImagePath;
        registeredDevices.refresh();
        break;
      }
    }
  }

  Future<void> sendDeviceToServer(String deviceName, File imageFile) async {
    final String? serverUrl = dotenv.env['ADD_DEVICE'];
    if (serverUrl == null) {
      print('Server URL not found in .env file');
      return;
    }

    var request = http.MultipartRequest('POST', Uri.parse(serverUrl));
    request.fields['homeId'] = loginController.homeId.value.toString(); // homeId를 String 값으로 전송
    request.fields['name'] = deviceName; // 사용자 입력 이름을 String 값으로 전송
    request.files.add(await http.MultipartFile.fromPath('photo', imageFile.path)); // 파일을 photo로 전송

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await http.Response.fromStream(response);
      var responseBody = jsonDecode(responseData.body);
      if (responseBody['status'] == '200') {
        print('Device registered successfully');
        print('Device ID: ${responseBody['data']['id']}');
        print('Device Name: ${responseBody['data']['name']}');
        print('Photo Path: ${responseBody['data']['photoPath']}');
        print('Home ID: ${responseBody['data']['homeId']}');
        deviceId.value = responseBody['data']['id'].toString(); // Device ID 저장
      } else {
        print('Failed to register device: ${responseBody['message']}');
      }
    } else {
      print('Failed to register device');
    }
  }
}

class Device {
  String name;
  String description;
  String imagePath;

  Device({required this.name, required this.description, required this.imagePath});
}