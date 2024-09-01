import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_test/Color/constants.dart';
import 'package:real_test/Controllers/Gesture/Gesture_List_Part_Controller.dart';

class GestureListPart extends StatelessWidget {
  final GestureListPartController controller = Get.find<GestureListPartController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        if (controller.gestures.isEmpty) {
          return Center(child: Text('No gestures available'));
        }

        return ListView.builder(
          itemCount: controller.gestures.length,
          itemBuilder: (context, index) {
            final gesture = controller.gestures[index];
            final image = gesture['image'] as Uint8List?;
            final name = gesture['name'] as String?;

            return Column(
              children: [
                ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: image != null
                        ? Image.memory(image)
                        : Image.asset('assets/placeholder.png'), // Placeholder image if image data is null
                  ),
                  title: Text('기능이름: $name'),
                ),
                const Divider(color: AppColors.greyLineColor, thickness: 0.5),
              ],
            );
          },
        );
      }),
    );
  }
}
