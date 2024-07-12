import 'package:flutter/material.dart';
import '../Camera_Page/Camera_Page.dart'; // Camera_Page.dart 파일을 임포트합니다.
import '../Dismiss_Keyboard.dart';

void main() {
  runApp(const SignUpPage());
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _confirmPasswordFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_confirmPasswordFocusNode.hasFocus) {
      _validatePasswords();
    }
  }

  void _validatePasswords() {
    setState(() {
      if (_passwordController.text != _confirmPasswordController.text) {
        _errorMessage = '비밀번호가 다릅니다.';
      } else {
        _errorMessage = '';
      }
    });
  }

  void _navigateToCameraPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CameraPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFFFF9D0),
        body: DismissKeyboard( // DismissKeyboard 위젯을 사용하여 키보드 숨기기 적용
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '회원가입',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'E.T.와 함께 삶의 질을 높여볼까요?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  Image.asset(
                    'assets/Sign_Up_Page.png',
                    height: 215, // Adjust the height as needed
                  ),
                  const SizedBox(height: 24),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: '아이디',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: '비밀번호',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _confirmPasswordController,
                    focusNode: _confirmPasswordFocusNode,
                    decoration: const InputDecoration(
                      labelText: '비밀번호 확인',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 8),
                  if (_errorMessage.isNotEmpty)
                    Text(
                      _errorMessage,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  const SizedBox(height: 24),
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
                        if (_passwordController.text == _confirmPasswordController.text) {
                          _navigateToCameraPage();
                        } else {
                          _validatePasswords();
                        }
                      },
                      child: const Text(
                        '삶의 질을 높이러 가기',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
