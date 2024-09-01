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
          if (controller.devices.isEmpty)
            Expanded(
              child: Center(child: Text('등록된 기기가 없습니다.')),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: controller.devices.length,
                itemBuilder: (context, index) {
                  final device = controller.devices[index];
                  final imageBytes = controller.imageBytes[index].value;
                  final bool isLastItem = index == controller.devices.length - 1;

                  return Column(
                    children: [
                      const Divider(color: AppColors.greyLineColor, thickness: 0.5, height: 1), // 각 기기 위에 회색선 추가
                      ListTile(
                        leading: imageBytes != null
                            ? Image.memory(imageBytes) // 바이너리 데이터를 이미지로 표시
                            : Icon(Icons.devices),
                        title: Text(device['name']),
                        subtitle: Text('ID: ${device['id'].toString()}'),  // ID를 String으로 변환
                        onTap: () {
                          Get.to(() => MainGesturePage(
                            photoPath: device['photoPath'],
                            title: device['name'],
                            deviceID: device['id'].toString(),  // deviceID를 String으로 변환하여 전달
                          ));
                        },
                      ),
                      if (isLastItem)
                        const Divider(color: AppColors.greyLineColor, thickness: 0.5, height: 1), // 마지막 기기 아래에 회색선 추가
                    ],
                  );
                },
              ),
            ),
          // 이곳에 추가적인 Divider는 제거하였습니다. 마지막 기기 아래에만 추가하므로 이곳에서는 필요 없습니다.
        ],
      );
    });
  }
}
