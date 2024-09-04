import 'dart:typed_data'; // Uint8List를 사용하기 위해 추가
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/Feature/Gesture_Choice_Controller.dart'; // Gesture_Choice_Controller 경로에 맞게 변경

class GestureChoice extends StatelessWidget {
  GestureChoice({super.key});

  final GestureChoiceController controller = Get.put(GestureChoiceController());

  Widget _buildGestureItem(String gestureName, String description, Uint8List imageData) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (controller.selectedGesture.value != gestureName) {
              controller.selectGesture(gestureName);
            }
          },
          child: Obx(() {
            final bool isSelected = controller.selectedGesture.value == gestureName;
            return Container(
              color: isSelected ? Colors.grey.withOpacity(0.5) : Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    Image.memory(
                      imageData, // 제스처 이미지 바이너리 데이터
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '제스처 아이디 : $gestureName',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '$description',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected ? const Color(0xFFD6A4FF) : const Color(0xFFCAF4FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      onPressed: isSelected ? null : () {
                        controller.selectGesture(gestureName);
                      },
                      child: const Text(
                        '선택',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        const Divider(color: Colors.grey, thickness: 0.5), // 얇은 회색 선 추가
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.gestures.isEmpty) {
        return const Center(
          child: Text('사용 가능한 제스처가 없습니다.'),
        );
      }

      return ListView.builder(
        itemCount: controller.gestures.length,
        itemBuilder: (context, index) {
          final gesture = controller.gestures[index];
          return _buildGestureItem(
            gesture['id'].toString(),
            gesture['explain'].toString(),
            gesture['image'] as Uint8List,
          );
        },
      );
    });
  }
}
