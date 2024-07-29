import 'package:flutter/material.dart';

class TitleAndLogo extends StatelessWidget {
  const TitleAndLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
