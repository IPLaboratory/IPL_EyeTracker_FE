import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_test/Color/constants.dart';
import 'package:real_test/Controllers/UserRegistration/Machine_Recogniton_Controller.dart'; // Controller import
import 'package:real_test/Feature_Settings_Page/Main_Settings.dart';
import 'package:real_test/Dismiss_Keyboard.dart'; // DismissKeyboard import
import 'package:image_picker/image_picker.dart'; // ImagePicker import

class ConnectedDevicePart extends StatefulWidget {
  @override
  _ConnectedDevicePartState createState() => _ConnectedDevicePartState();
}

class _ConnectedDevicePartState extends State<ConnectedDevicePart> {
  final MachineRecognitionController controller = Get.put(MachineRecognitionController());
  final TextEditingController _textController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    _textController.text = controller.currentDevice.value;
    _textController.addListener(() {
      controller.currentDevice.value = _textController.text;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imageFile = pickedFile;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Column(
        children: [
          const Text(
            '기기 등록',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(color: AppColors.greyLineColor, thickness: 1), // 얇은 회색 선 추가
          const SizedBox(height: 10), // 회색선과 텍스트 사이 간격 조절
          const Center( // 중앙 정렬을 위해 Center 위젯 사용
            child: Text(
              '현재 접속한 기기를 등록할까요?',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 10), // 회색선과 텍스트 사이 간격 조절
          const Divider(color: AppColors.greyLineColor, thickness: 1), // 텍스트 밑에 얇은 회색 선 추가
          const SizedBox(height: 20),
          Row(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 45,
                  height: 45,
                  child: _imageFile == null
                      ? Image.asset(
                    'assets/Camera_Test.png', // 현재 기기 이미지 경로
                    fit: BoxFit.cover,
                  )
                      : Image.file(
                    File(_imageFile!.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    labelText: '등록할 기기',
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCAF4FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainSettingsPage()),
                );
              },
              child: const Text(
                '기능 설정하러 가기',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(color: AppColors.greyLineColor, thickness: 1), // 얇은 회색 선 추가
        ],
      ),
    );
  }
}
