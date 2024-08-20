import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert'; // base64Decode 사용
import '../Controllers/Profile/Change_Profile_Controller.dart';
import '../Controllers/Profile/Models_Profile.dart'; // ModelsProfile 임포트

class ChangeProfilePage extends StatefulWidget {
  final ModelsProfile profile; // 프로필 데이터 추가

  const ChangeProfilePage({Key? key, required this.profile}) : super(key: key); // 생성자 수정

  @override
  _ChangeProfilePageState createState() => _ChangeProfilePageState();
}

class _ChangeProfilePageState extends State<ChangeProfilePage> {
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.profile.name); // 초기값 설정
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFFFF9D0), // 배경색 설정
          appBar: AppBar(
            scrolledUnderElevation: 0, //스크롤시 AppBar 그림자 색 0으로 해주기
            backgroundColor: const Color(0xFFFFF9D0),
            elevation: 0, // 그림자 제거
            actions: [
              const SizedBox(width: 10), // 약간의 간격 추가
            ],
          ),
          body: SafeArea( // 상단과 하단의 여백을 유지하기 위해 SafeArea 사용
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16.0), // 상하 여백 추가
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 5),
                  const AdjustableText(
                    text: 'E.T',
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 14),
                  const AdjustableText(
                    text: '자유롭게 프로필을 수정하세요.',
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 60),
                  Obx(() {
                    return Stack(
                      children: [
                        if (controller.selectedImage.value == null)
                          Container(
                            width: 150,
                            height: 149,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              image: DecorationImage(
                                image: widget.profile.photoPath != null && widget.profile.photoPath!.isNotEmpty
                                    ? NetworkImage(widget.profile.photoPath!)
                                    : widget.profile.photoBase64 != null && widget.profile.photoBase64!.isNotEmpty
                                    ? MemoryImage(base64Decode(widget.profile.photoBase64!))
                                    : const AssetImage('assets/Default_Profile.jpg') as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        if (controller.selectedImage.value != null)
                          Container(
                            width: 150,
                            height: 149,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              image: DecorationImage(
                                image: FileImage(File(controller.selectedImage.value!.path)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: () {
                              controller.getImage(ImageSource.gallery);
                            },
                            icon: const Icon(Icons.edit, size: 25),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: widget.profile.name, // 선택한 프로필의 이름 표시
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                        // 저장 버튼 클릭 시 동작 추가
                        if (controller.selectedImage.value != null) {
                          //controller.uploadImage(controller.selectedImage.value!.path);
                          controller.uploadImage(widget.profile.id, nameController.text, controller.selectedImage.value!.path);
                        } else {
                          // 이미지가 선택되지 않았을 경우 id와 text만 넘김
                          controller.uploadjustname(widget.profile.id, nameController.text);
                        }
                      },
                      child: const Text(
                        '저장',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // 마지막 버튼 아래에 공간 추가
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class AdjustableText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color color;

  const AdjustableText({
    required this.text,
    required this.fontSize,
    this.fontWeight,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color,
      ),
    );
  }
}
