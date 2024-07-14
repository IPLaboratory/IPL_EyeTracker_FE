import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dismiss_keyboard.dart';
import '../providers/login_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    final usernameFocusNode = FocusNode();
    final passwordFocusNode = FocusNode();

    void _unfocusAll() {
      usernameFocusNode.unfocus();
      passwordFocusNode.unfocus();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9D0),
      body: DismissKeyboard(
        child: GestureDetector(
          onTap: _unfocusAll,
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
                    ),
                  ),
                  const SizedBox(height: 0),
                  const Text(
                    '귀찮음은 끝이 없으니까',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: SizedBox(
                      width: 250,
                      height: 250,
                      child: Image.asset(
                        'assets/Main_Page.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        TextField(
                          focusNode: usernameFocusNode,
                          onChanged: (value) => loginProvider.setUsername(value),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '로그인',
                          ),
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(passwordFocusNode);
                          },
                        ),
                        const SizedBox(height: 17),
                        TextField(
                          focusNode: passwordFocusNode,
                          onChanged: (value) => loginProvider.setPassword(value),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '비밀번호',
                          ),
                          obscureText: true,
                          onEditingComplete: () {
                            _unfocusAll();
                          },
                        ),
                        const SizedBox(height: 17),
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
                              _unfocusAll();
                              loginProvider.login(context);
                            },
                            child: const Text(
                              '로그인',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'E.T.의 회원이 아니신가요?',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _unfocusAll();
                            loginProvider.navigateToSignUp(context);
                          },
                          child: const Text(
                            '지금 가입하세요.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF5AB2FF),
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
      ),
    );
  }
}
