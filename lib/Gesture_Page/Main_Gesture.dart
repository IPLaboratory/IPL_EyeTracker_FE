import 'package:flutter/material.dart';
import 'package:real_test/Profile_Page/Main_Profile.dart';

class MainGesturePage extends StatefulWidget {
  const MainGesturePage({super.key});


  @override
  _MainGesturePageState createState() => _MainGesturePageState();
}

class _MainGesturePageState extends State<MainGesturePage> {
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9D0),
      appBar: AppBar(
      backgroundColor: const Color(0xFFFFF9D0),
      //backgroundColor: const Color(0xFFFFd9D0),// 배경색 설정
      elevation: 0, // 그림자 제거
      actions: [
        const SizedBox(width: 10), // 약간의 간격 추가
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Center(
              child: Text(
                '현재 연결된 기기입니다. 원하는 기능을 이용하세요.',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, 15),
              child: SizedBox(
                width: 150,
                height: 150,
                child: Image.asset(
                  'assets/fan.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 7),
            const AdjustableText(
              text: '선풍기',
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            const SizedBox(height: 20),
            const SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '기능목록',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(color: Colors.grey, thickness: 1), //얇은 회색 선 추가
                ],
              ),
            ),
            Expanded(
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
                  const Divider(color: Colors.grey, thickness: 0.5),
                  ListTile(
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset('assets/off.png'),
                    ),
                    title: const Text('기능이름: OFF'),
                    subtitle: const Text('제스처 설명: 눈동자를 이러쿵 저러쿵 한다.'),
                  ),
                    const Divider(color: Colors.grey, thickness: 0.5),
                  ListTile(
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset('assets/skills.png'),
                    ),
                    title: const Text('기능이름: 바람 세기'),
                    subtitle: const Text('제스처 설명: 눈동자를 이러쿵 저러쿵 한다.'),
                  ),
                  const Divider(color: Colors.grey, thickness: 0.5),
                  ListTile(
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset('assets/skills.png'),
                    ),
                    title: const Text('기능이름: 회전'),
                    subtitle: const Text('제스처 설명: 눈동자를 이러쿵 저러쿵 한다.'),
                  ),
                  const Divider(color: Colors.grey, thickness: 0.5),
                  ListTile(
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset('assets/skills.png'),
                    ),
                    title: const Text('기능이름: 작동 시간 예약'),
                    subtitle: const Text('제스처 설명: 눈동자를 이러쿵 저러쿵 한다.'),
                  ),
                  const Divider(color: Colors.grey, thickness: 0.5),
                  ListTile(
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset('assets/skills.png'),
                    ),
                    title: const Text('기능이름: 자연풍'),
                    subtitle: const Text('제스처 설명: 눈동자를 이러쿵 저러쿵 한다.'),
                  ),
                  const Divider(color: Colors.grey, thickness: 0.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}