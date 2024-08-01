import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_test/Controllers/UserRegistration/Machine_Recogniton_Controller.dart';
import 'package:real_test/Color/constants.dart';

class AlreadyDevicePart extends StatelessWidget {
  final MachineRecognitionController controller = Get.put(MachineRecognitionController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() => ListView(
        children: controller.registeredDevices.map((device) {
          return Column(
            children: [
              const Divider(color: AppColors.greyLineColor, thickness: 0.5), // 기기 위에 얇은 회색 선 추가
              ListTile(
                leading: SizedBox(
                  width: 50, // 이미지 너비 조절
                  height: 50, // 이미지 높이 조절
                  child: Image.asset(device.imagePath), // 기기 아이콘 경로
                ),
                title: Text(device.name),
                subtitle: Text(device.description),
                onTap: () {
                  // 기기 클릭 시 기능 추가 예정
                },
              ),
            ],
          );
        }).toList(),
      )),
    );
  }
}