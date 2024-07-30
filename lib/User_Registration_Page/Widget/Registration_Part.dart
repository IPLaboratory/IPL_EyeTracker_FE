import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:real_test/Color/constants.dart';
import 'package:real_test/Controllers/UserRegistration/User_Registration_Controller.dart';

class RegistrationPart extends StatelessWidget{
  final UserRegistrationController controller = Get.put(UserRegistrationController());

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  leading: GestureDetector(
                    onTap: () => _navigateToCameraPage(index),
                    child: Obx(() {
                      final imagePath = controller.imagePaths[index].value;
                      return SizedBox(
                        width: 50, // 이미지 너비 조절
                        height: 50, // 이미지 높이 조절
                        child: imagePath.startsWith('assets/')
                            ? Image.asset(
                          imagePath,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                            : Image.file(
                          File(imagePath),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      );
                    }),
                  ),
                  title: TextField(
                    controller: controller.nameControllers[index],
                    decoration: InputDecoration(
                      hintText: '이름을 작성해 주세요.',
                      hintStyle: const TextStyle(color: AppColors.greyTextColor, fontSize: 14),
                      border: InputBorder.none,
                      filled: false, // 배경 색상을 적용하지 않음
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    style: const TextStyle(fontSize: 14),
                    cursorColor: Colors.black,
                    cursorWidth: 1.0,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                  ),
                  subtitle: TextField(
                    controller: controller.descriptionControllers[index],
                    decoration: InputDecoration(
                      hintText: '설명을 작성해 주세요.',
                      hintStyle: const TextStyle(color: AppColors.greyTextColor, fontSize: 14),
                      border: InputBorder.none,
                      filled: false, // 배경 색상을 적용하지 않음
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    style: const TextStyle(fontSize: 14),
                    cursorColor: Colors.black,
                    cursorWidth: 1.0,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                  ),
                  onTap: () {
                    // 기기 클릭 시 기능 추가 예정
                  },
                ),
                const Divider(color: AppColors.greyLineColor, thickness: 0.5, height: 1), // 각 기기 사이에 얇은 회색 선 및 간격 조절
              ],
            );
          },
        ),
      ],
    );
  }

  Future<void> _navigateToCameraPage(int index) async {
    final picker = ImagePicker();

    if (!await Permission.camera.request().isGranted) {
      // 카메라 접근 권한 요청
      return;
    }

    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      controller.updateImagePath(index, pickedFile.path);
    }
  }
}