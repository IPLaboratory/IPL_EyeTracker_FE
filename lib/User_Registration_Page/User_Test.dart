import 'package:flutter/material.dart';
import '../Profile_Page/Main_Profile.dart'; // 경로를 실제 위치에 맞게 조정하세요

class UserTestPage extends StatelessWidget {
  const UserTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9D0), // 배경색 설정
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'This is the User Test Page',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainProfilePage()),
                );
              },
              child: const Text('Go to Main Profile Page'),
            ),
          ],
        ),
      ),
    );
  }
}
