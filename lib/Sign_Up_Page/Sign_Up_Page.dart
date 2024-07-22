import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/Sign_Up_Provider.dart';
import '../Dismiss_Keyboard.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpProvider(),
      child: const SignUpPageContent(),
    );
  }
}

class SignUpPageContent extends StatelessWidget {
  const SignUpPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9D0),
      body: DismissKeyboard(
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
                TextField(
                  onChanged: (value) => signUpProvider.setUsername(value),
                  decoration: const InputDecoration(
                    labelText: '아이디',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (value) => signUpProvider.setPassword(value),
                  decoration: const InputDecoration(
                    labelText: '비밀번호',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (value) => signUpProvider.setConfirmPassword(value),
                  decoration: const InputDecoration(
                    labelText: '비밀번호 확인',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 8),
                if (signUpProvider.errorMessage.isNotEmpty)
                  Text(
                    signUpProvider.errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
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
                      signUpProvider.navigateToMainProfilePage(context);
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
    );
  }
}
