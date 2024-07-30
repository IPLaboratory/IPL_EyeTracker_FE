import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../Profile_Page/Main_Profile.dart';
import '../Controllers/Profile/Change_Profile_Controller.dart';

class ChangeProfilePage extends StatelessWidget {
  const ChangeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFFFF9D0), // 배경색 설정
          appBar: AppBar(
            backgroundColor: const Color(0xFFFFF9D0),
            elevation: 0, // 그림자 제거
            actions: [
              const SizedBox(width: 10), // 약간의 간격 추가
            ],
          ),
          body: Center(
            child: Column(
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
                            image: const DecorationImage(
                              image: AssetImage('assets/character1.jpg'),
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
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '캐릭터1',
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(), // 빈 공간을 채워 버튼을 아래로 배치
                Padding(
                  padding: const EdgeInsets.all(16.0), // 버튼 주위에 여백 추가
                  child: Column(
                    children: [
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
                              controller.patchUserProfileImage(controller.selectedImage.value!.path);
                            } else {
                              print("이미지가 선택되지 않았습니다.");
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
                    ],
                  ),
                ),
              ],
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
    super.key,
  });

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