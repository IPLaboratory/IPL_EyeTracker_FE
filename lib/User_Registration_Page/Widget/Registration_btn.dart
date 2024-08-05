import 'package:flutter/material.dart';
import 'package:real_test/Color/constants.dart'; // 칼라 임포트
import 'package:real_test/Gesture_Page/Main_Gesture.dart';
import 'package:real_test/User_Registration_Page/Machine_Recognition.dart';

class RegistrationBtn extends StatelessWidget {
  final double? width;
  final double? height;

  const RegistrationBtn({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonColor,
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
              backgroundColor: AppColors.buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MainGesturePage()),
              );
            },
            child: const Text(
              '제스처 선택(기능목록)',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// 페이지 간 애니메이션 넣기
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => MachineRecognitionPage(),
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
