import 'package:flutter/material.dart';
import '../Sign_Up_Page/Sign_Up_Page.dart';
import '../User_Registration_Page/User_Registration.dart';
import '../dismiss_keyboard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9D0), // 배경색을 #FFF9D0로 설정
      body: DismissKeyboard(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'E.T.',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    // color: Color(0xFF5AB2FF),
                  ),
                ),
                const SizedBox(height: 0), // E.T. 텍스트와 설명 텍스트 사이의 간격
                const Text(
                  '귀찮음은 끝이 없으니까',
                  style: TextStyle(
                    // color: Color(0xFF5AB2FF),
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 25), // 설명 텍스트와 이미지 사이의 간격
                Center(
                  child: SizedBox(
                    width: 250, // 원하는 너비 설정
                    height: 250, // 원하는 높이 설정
                    child: Image.asset(
                      'assets/Main_Page.png',
                      fit: BoxFit.contain, // 이미지를 컨테이너에 맞게 조정
                    ),
                  ),
                ),
                const SizedBox(height: 25), // 이미지와 로그인 필드 사이의 간격
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '로그인',
                        ),
                      ),
                      const SizedBox(height: 17), // 로그인 필드와 비밀번호 필드 사이의 간격
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '비밀번호',
                        ),
                        obscureText: true, // 비밀번호 텍스트 필드
                      ),
                      const SizedBox(height: 17), // 비밀번호 필드와 버튼 사이의 간격
                      SizedBox(
                        width: double.infinity, // 버튼을 화면 너비에 꽉 채우도록 설정
                        height: 50, // 버튼 높이 설정
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFCAF4FF), // 버튼 배경색 설정
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0), // TextField와 동일한 둥근 모서리
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const UserRegistrationPage()),
                            );
                          },
                          child: const Text(
                            '로그인',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // 버튼 텍스트 색상 설정
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10), // 버튼과 텍스트 사이의 간격
                      const Text(
                        'E.T.의 회원이 아니신가요?',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey, // 회색 글씨
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpPage()),
                          );
                        },
                        child: const Text(
                          '지금 가입하세요.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF5AB2FF), // 색깔을 5AB2FF로 설정
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
