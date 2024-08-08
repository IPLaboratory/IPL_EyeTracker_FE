import 'package:flutter/material.dart';
import 'package:real_test/Color/constants.dart';
import 'package:real_test/Profile_Page/Main_Profile.dart';
import 'Gesture_List_Part.dart';

class MainGesturePage extends StatefulWidget {
  final String? photoPath;  // 이미지 경로를 받는 매개변수 추가
  final String title;  // title을 받는 매개변수 추가

  const MainGesturePage({super.key, this.photoPath, required this.title});

  @override
  _MainGesturePageState createState() => _MainGesturePageState();
}

class _MainGesturePageState extends State<MainGesturePage> {
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0, //스크롤시 AppBar 그림자 색 0으로 해주기
        backgroundColor: AppColors.backgroundColor,
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),  // 둥근 모서리 반지름 설정
                child: SizedBox(
                  width: 140,
                  height: 140,
                  child: widget.photoPath != null
                      ? Image.network(widget.photoPath!)
                      : Image.asset(
                    'assets/기본사물.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            AdjustableText(
              text: widget.title,  // 전달받은 title을 표시
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
                  Divider(color: AppColors.textColor, thickness: 1), //얇은 회색 선 추가
                ],
              ),
            ),
            GestureListPart(),
          ],
        ),
      ),
    );
  }
}