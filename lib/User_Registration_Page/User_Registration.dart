import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:real_test/Controllers/UserRegistration/User_Registration_Controller.dart';
import 'package:real_test/User_Registration_Page/Machine_Recognition.dart';

class UserRegistrationPage extends StatelessWidget {
  final UserRegistrationController controller = Get.put(UserRegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // 키보드가 올라올 때 화면이 조정되도록 설정
      backgroundColor: const Color(0xFFFFF9D0), // 배경색 설정
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF9D0), // 배경색 설정
        elevation: 0, // 그림자 제거
        scrolledUnderElevation: 0, // 스크롤 시 그림자 제거
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/Test_Profile.png', // 이미지 경로
              width: 25,
              height: 35,
            ),
            onPressed: () {
              // 버튼 기능 추가 예정
            },
          ),
          const SizedBox(width: 10), // 약간의 간격 추가
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '등록된 기기',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(color: Colors.grey, thickness: 1), // 등록된 기기 밑에 얇은 회색 선
                    const SizedBox(height: 0), // 간격 조절
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
                                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
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
                                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
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
                            const Divider(color: Colors.grey, thickness: 0.5, height: 1), // 각 기기 사이에 얇은 회색 선 및 간격 조절
                          ],
                        );
                      },
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
                          Navigator.of(context).push(
                            _createRoute(),
                          );
                        },
                        child: const Text(
                          '기기 등록하러 가기',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
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
                          showWarningSnackbar(context);
                        },
                        child: const Text(
                          'Test',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
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

  void showWarningSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: AwesomeSnackbarContent(
        title: '이런!',
        message: '기기 인식이 제대로 안 됐어요.\n 다시 한 번 기기에 눈을 마주쳐 주세요.',
        contentType: ContentType.warning,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

//페이지 간 애니메이션 넣기
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondartAnimation) => MachineRecognitionPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeIn;
      final tween = Tween(begin: begin, end: end);

      final curvedAnimation = CurvedAnimation(parent: animation, curve: curve);

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}
