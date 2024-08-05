import 'package:get/get.dart';

class MachineRecognitionController extends GetxController {
  RxString currentDevice = ''.obs;
  final List<Device> registeredDevices = [
    Device(name: '선풍기', description: '시원한 바람이 나오는 가전제품이다.', imagePath: 'assets/fan.jpg'),
    Device(name: '무드등', description: '분위기를 만들어주는 가전제품이다.', imagePath: 'assets/light.jpg'),
    Device(name: 'TV', description: '시청할 수 있는 가전제품이다.', imagePath: 'assets/TV.jpg'),
  ].obs;

  void registerDevice(String deviceName) {
    currentDevice.value = deviceName;
  }
}

class Device {
  final String name;
  final String description;
  final String imagePath;

  Device({required this.name, required this.description, required this.imagePath});
}
