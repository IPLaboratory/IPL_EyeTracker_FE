import 'package:flutter/material.dart';

class UserTestPage extends StatelessWidget {
  const UserTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9D0), // 배경색 설정
      body: Center(
        child: Text(
          'This is the User Test Page',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
