import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_test/Controllers/UserRegistration/User_Registration_Controller.dart';
import 'package:real_test/Color/constants.dart';

class RegistrationPart extends StatelessWidget {
  final UserRegistrationController controller = Get.put(UserRegistrationController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: AppColors.greyLineColor, thickness: 0.5, height: 1), // 등록된 기기 바로 아래 회색선
        SizedBox(height: 410), // 빈 여백을 추가 (200 높이로 설정)
        const Divider(color: AppColors.greyLineColor, thickness: 0.5, height: 1), // 맨 아래 회색선
      ],
    );
  }
}
