import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/Feature/Gesture_Choice_Controller.dart'; // Gesture_Choice_Controller 경로에 맞게 변경

class GestureChoice extends StatelessWidget {
  GestureChoice({super.key});

  final GestureChoiceController controller = Get.put(GestureChoiceController());

  Widget _buildGestureItem(String gestureName, String description, String imagePath) {
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
                    Image.asset(
                      imagePath, // 제스처 이미지 경로
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '제스처명 : $gestureName',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '설명: $description',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected ? Color(0xFFD6A4FF) : const Color(0xFFCAF4FF),
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
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildGestureItem('북쪽', '무섭다.', 'assets/Gesture_Image.png'),
        _buildGestureItem('남쪽', '두렵다.', 'assets/Gesture_Image.png'),
        _buildGestureItem('동쪽', '재밌다.', 'assets/Gesture_Image.png'),
        _buildGestureItem('서쪽', '즐겁다.', 'assets/Gesture_Image.png'),
        _buildGestureItem('동남쪽', '행복하다.', 'assets/Gesture_Image.png'),
        _buildGestureItem('서남쪽', '슬프다.', 'assets/Gesture_Image.png'),
        _buildGestureItem('동북쪽', '우울하다.', 'assets/Gesture_Image.png'),
        _buildGestureItem('서북쪽', '화난다.', 'assets/Gesture_Image.png'),
      ],
    );
  }
}
