import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_test/Controllers/UserRegistration/User_Registration_Controller.dart';
import 'package:real_test/Color/constants.dart';
import 'package:real_test/Gesture_Page/Main_Gesture.dart';

class RegistrationPart extends StatelessWidget {
  final UserRegistrationController controller = Get.put(UserRegistrationController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          const Divider(color: AppColors.greyLineColor, thickness: 0.5, height: 1), // 등록된 기기 바로 아래 회색선
          if (controller.devices.isEmpty)
            Expanded(
              child: Center(child: Text('등록된 기기가 없습니다.')),
            )
          else
            Expanded(
              child: ListView(
                children: controller.devices.map((device) => ListTile(
                  leading: device['photoPath'] != null
                      ? Image.network(device['photoPath'])
                      : Icon(Icons.devices),
                  title: Text(device['name']),
                  subtitle: Text('ID: ${device['id']}'),
                  onTap: () {
                    Get.to(() => MainGesturePage(photoPath: device['photoPath'], title: device['name']));  // 페이지 이동 시 이미지 경로 전달
                  },
                )).toList(),
              ),
            ),
          const Divider(color: AppColors.greyLineColor, thickness: 0.5, height: 1), // 맨 아래 회색선
        ],
      );
    });
  }
}