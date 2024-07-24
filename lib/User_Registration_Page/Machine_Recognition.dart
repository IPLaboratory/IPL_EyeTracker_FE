import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:real_test/Feature_Settings_Page/Main_Settings.dart';

class MachineRecognitionPage extends StatelessWidget {
  const MachineRecognitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9D0), // 배경색 설정
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF9D0), // 배경색 설정
        scrolledUnderElevation: 0,
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
              '기기 등록',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(color: Colors.grey, thickness: 1), // 얇은 회색 선 추가
            const SizedBox(height: 10), // 회색선과 텍스트 사이 간격 조절
            const Center( // 중앙 정렬을 위해 Center 위젯 사용
              child: Text(
                '현재 접속한 기기를 등록할까요?',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 10), // 회색선과 텍스트 사이 간격 조절
            const Divider(color: Colors.grey, thickness: 1), // 텍스트 밑에 얇은 회색 선 추가
            const SizedBox(height: 20),
            Row(
              children: [
                Image.asset(
                  'assets/Hot_Light.jpg', // 현재 기기 이미지 경로
                  width: 40,
                  height: 40,
                ),
                const SizedBox(width: 10),
                const Text(
                  '현재 접속 기기: 온열등', // 현재 접속된 기기 정보
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCAF4FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainSettingsPage()),
                  );
                },
                child: const Text(
                  '기기 등록',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.grey, thickness: 1), // 얇은 회색 선 추가
            const Text(
              '등록된 기기',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(color: Colors.grey, thickness: 1), // 얇은 회색 선 추가
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  const Divider(color: Colors.grey, thickness: 0.5), // 선풍기 위에 얇은 회색 선 추가
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
