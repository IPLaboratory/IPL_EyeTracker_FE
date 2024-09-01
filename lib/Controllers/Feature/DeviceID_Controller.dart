import 'package:get/get.dart';

class DeviceController extends GetxController {
  var deviceid = ''.obs;

  void setDeviceID(String id) {
    print('Setting Device ID: $id');  // 로그 추가: 저장하려는 deviceID 값을 출력
    deviceid.value = id;
  }

  String get getDeviceID {
    print('Getting Device ID: ${deviceid.value}');  // 로그 추가: 가져오려는 deviceID 값을 출력
    return deviceid.value;
  }
}
