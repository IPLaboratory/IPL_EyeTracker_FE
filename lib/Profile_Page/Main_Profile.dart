import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // SVG 파일 사용을 위한 패키지
import 'package:get/get.dart';
import 'dart:convert';// base64Decode 함수 사용을 위해 추가
import '../Camera_Page/Camera_Page.dart'; // CameraPage 파일 임포트
import '../Profile_Page/Change_Profile.dart'; // ChangeProfile 파일 임포트
import '../User_Registration_Page/Widget/User_Registration.dart'; // UserRegistrationPage 파일 임포트
import '../Controllers/Profile/Main_Profile_Controller.dart'; // MainProfileController 임포트
import '../Controllers/Profile/Controller_Profile.dart'; // ControllerProfile 임포트
import '../Color/constants.dart';

class MainProfilePage extends StatelessWidget {
  const MainProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ControllerProfile profileController = Get.put(ControllerProfile());

    return GetBuilder<MainProfileController>(
      init: MainProfileController(),
      builder: (controller) {
        return GetBuilder<ControllerProfile>(
          init: ControllerProfile(),
          builder: (profileController) {
            return Scaffold(
              backgroundColor: AppColors.backgroundColor,
              appBar: AppBar(
                scrolledUnderElevation: 0,
                backgroundColor: AppColors.backgroundColor,
                elevation: 0,
                actions: [
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/Pencil.svg',
                      width: 30,
                      height: 30,
                    ),
                    onPressed: () {
                      controller.toggleChange();
                    },
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    const AdjustableText(
                      text: 'E.T.',
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                    const SizedBox(height: 14),
                    const AdjustableText(
                      text: '아이트랙킹할 프로필을 선택해주세요.',
                      fontSize: 20,
                      color: AppColors.textColor,
                    ),
                    Expanded(
                      child: Obx(() {
                        if (profileController.profiles.isEmpty) {
                          return Transform.translate(
                            offset: const Offset(0, 57),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () async {
                                        await Get.to(() => CameraPage(onProfileAdded: controller.addProfile));
                                      },
                                      child: Container(
                                        width: 130,
                                        height: 129,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.add,
                                            size: 70,
                                            color: AppColors.textColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 130,
                                      height: 129,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: Wrap(
                                    spacing: 20.0,
                                    runSpacing: 20.0,
                                    children: List.generate(profileController.profiles.length, (index) {
                                      final profile = profileController.profiles[index];
                                      return GestureDetector(
                                        onTap: () => Get.to(() => UserRegistrationPage()),
                                        child: Container(
                                          width: 150,
                                          height: 170,
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                width: 130,
                                                height: 129,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20.0),
                                                  image: DecorationImage(
                                                    image: profile.photoPath != null && profile.photoPath!.isNotEmpty
                                                        ? NetworkImage(profile.photoPath!)
                                                        : (profile.photoBase64 != null && profile.photoBase64!.isNotEmpty)
                                                        ? MemoryImage(base64Decode(profile.photoBase64!))
                                                        : AssetImage('assets/Default_Profile.jpg') as ImageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                child: controller.isChange.value
                                                    ? IconButton(
                                                  onPressed: () {
                                                    Get.to(() => ChangeProfilePage(profile: profile));
                                                  },
                                                  icon: const Icon(Icons.edit, size: 30),
                                                  color: Colors.white,
                                                )
                                                    : Container(),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    profile.name,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontFamily: 'Maple',
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                                if (profileController.profiles.length < 5) const SizedBox(height: 50),
                              ],
                            ),
                          );
                        }
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFCAF4FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          onPressed: () async {
                            await Get.to(() => CameraPage(onProfileAdded: controller.addProfile));
                          },
                          child: const Text(
                            '프로필 추가하기',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
