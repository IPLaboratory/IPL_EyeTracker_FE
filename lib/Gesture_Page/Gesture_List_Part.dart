import 'package:flutter/material.dart';
import 'package:real_test/Color/constants.dart';

class GestureListPart extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: Image.asset('assets/on.png'),
            ),
            title: const Text('기능이름: ON'),
            subtitle: const Text('제스처 설명: 눈동자를 이러쿵 저러쿵 한다.'),
          ),
          const Divider(color: AppColors.greyLineColor, thickness: 0.5),
          ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: Image.asset('assets/off.png'),
            ),
            title: const Text('기능이름: OFF'),
            subtitle: const Text('제스처 설명: 눈동자를 이러쿵 저러쿵 한다.'),
          ),
          const Divider(color: AppColors.greyLineColor, thickness: 0.5),
          ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: Image.asset('assets/skills.png'),
            ),
            title: const Text('기능이름: 바람 세기'),
            subtitle: const Text('제스처 설명: 눈동자를 이러쿵 저러쿵 한다.'),
          ),
          const Divider(color: AppColors.greyLineColor, thickness: 0.5),
          ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: Image.asset('assets/skills.png'),
            ),
            title: const Text('기능이름: 회전'),
            subtitle: const Text('제스처 설명: 눈동자를 이러쿵 저러쿵 한다.'),
          ),
          const Divider(color: AppColors.greyLineColor, thickness: 0.5),
          ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: Image.asset('assets/skills.png'),
            ),
            title: const Text('기능이름: 작동 시간 예약'),
            subtitle: const Text('제스처 설명: 눈동자를 이러쿵 저러쿵 한다.'),
          ),
          const Divider(color: AppColors.greyLineColor, thickness: 0.5),
          ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: Image.asset('assets/skills.png'),
            ),
            title: const Text('기능이름: 자연풍'),
            subtitle: const Text('제스처 설명: 눈동자를 이러쿵 저러쿵 한다.'),
          ),
          const Divider(color: AppColors.greyLineColor, thickness: 0.5),
        ],
      ),
    );
  }
}