import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:real_test/Color/constants.dart';
import 'package:real_test/Controllers/UserRegistration/Machine_Recogniton_Controller.dart'; // Controller import
import 'package:real_test/Dismiss_Keyboard.dart'; // DismissKeyboard import

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

  Future<void> _registerDevice() async {
    if (_textController.text.isNotEmpty && _imageFile != null) {
      File imageFile = File(_imageFile!.path);
      bool success = await controller.sendDeviceToServer(_textController.text, imageFile);

      if (success) {
        // 서버 전송 성공 시 스낵바 표시
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: '등록 성공!',
            message: '기기가 성공적으로 등록되었습니다!\n등록된 기기 페이지로 돌아가 주세요!',
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else {
        // 서버 전송 실패 시 스낵바 표시
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: '등록 실패',
            message: '기기 등록에 실패했습니다. 다시 시도해 주세요.',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } else {
      // 필드가 비어있거나 이미지가 선택되지 않았을 때 처리
      Get.snackbar('Error', 'Device name or image is missing');
    }
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
              onPressed: _registerDevice, // 기기 등록하기 버튼 클릭 시 호출
              child: const Text(
                '기기 등록하기',
                style: TextStyle(
                  fontSize: 20,
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
