import 'package:flutter/material.dart';

class UserRegistrationPage extends StatelessWidget {
  const UserRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9D0), // 배경색 설정
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF9D0), // 배경색 설정
        elevation: 0, // 그림자 제거
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/Test_Profile.png', // 이미지 경로
              width: 35,
              height: 35,
            ),
            onPressed: () {
              // 버튼 기능 추가 예정
            },
          ),
          const SizedBox(width: 10), // 약간의 간격 추가
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '등록된 기기',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(color: Colors.grey, thickness: 1), // 등록된 기기 밑에 얇은 회색 선
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: SizedBox(
                      width: 50, // 이미지 너비 조절
                      height: 50, // 이미지 높이 조절
                      child: Image.asset('assets/fan.jpg'), // 기기 아이콘 경로
                    ),
                    title: const Text('선풍기'),
                    subtitle: const Text('시원한 바람이 나오는 가전제품이다.'),
                    onTap: () {
                      // 기기 클릭 시 기능 추가 예정
                    },
                  ),
                  const Divider(color: Colors.grey, thickness: 0.5), // 각 기기 사이에 얇은 회색 선
                  ListTile(
                    leading: SizedBox(
                      width: 50, // 이미지 너비 조절
                      height: 50, // 이미지 높이 조절
                      child: Image.asset('assets/light.jpg'), // 기기 아이콘 경로
                    ),
                    title: const Text('무드등'),
                    subtitle: const Text('분위기를 만들어주는 가전제품이다.'),
                    onTap: () {
                      // 기기 클릭 시 기능 추가 예정
                    },
                  ),
                  const Divider(color: Colors.grey, thickness: 0.5), // 각 기기 사이에 얇은 회색 선
                  ListTile(
                    leading: SizedBox(
                      width: 50, // 이미지 너비 조절
                      height: 50, // 이미지 높이 조절
                      child: Image.asset('assets/TV.jpg'), // 기기 아이콘 경로
                    ),
                    title: const Text('TV'),
                    subtitle: const Text('시청할 수 있는 가전제품이다.'),
                    onTap: () {
                      // 기기 클릭 시 기능 추가 예정
                    },
                  ),
                  const Divider(color: Colors.grey, thickness: 0.5), // 각 기기 사이에 얇은 회색 선
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
