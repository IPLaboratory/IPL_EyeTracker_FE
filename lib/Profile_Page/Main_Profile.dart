import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // SVG 파일 사용을 위한 패키지
import '../Camera_Page/Camera_Page.dart';

class MainProfilePage extends StatefulWidget {
  const MainProfilePage({super.key});

  @override
  _MainProfilePageState createState() => _MainProfilePageState();
}

class _MainProfilePageState extends State<MainProfilePage> {
  bool _isImageVisible = true;
  bool _isChange = false;
  int chk = 0;

  void _addProfile() {
    setState(() {
      _isImageVisible = false;
      chk += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9D0), // 배경색 설정
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF9D0), // 배경색 설정
        elevation: 0, // 그림자 제거
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/Pencil.svg', // SVG 파일 경로
              width: 30,
              height: 30,
            ),
            onPressed: () {
              setState(() {
                _isChange = true;
              });
            },
          ),
          const SizedBox(width: 10), // 약간의 간격 추가
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 5), // 원하는 높이로 조절 가능
            AdjustableText(
              text: 'E.T.',
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            const SizedBox(height: 14),
            AdjustableText(
              text: '아이트랙킹할 프로필을 추가해주세요.',
              fontSize: 20,
              color: Colors.black,
            ),
            if (_isImageVisible)
              Transform.translate(
                offset: const Offset(0, 57), // 텍스트 아래로 이동
                child: SizedBox(
                  width: 300, // 원하는 너비로 조절
                  height: 300, // 원하는 높이로 조절
                  child: Image.asset(
                    'assets/Main_Profile.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            if (!_isImageVisible)
              Container(
                width: double.infinity,
                height: 300,
                margin: const EdgeInsets.fromLTRB(70, 30, 70, 0),
                child: Wrap(
                  spacing: 50, // 자식 요소 간의 수평 간격
                  runSpacing: 40.0, // 자식 요소 간의 수직 간격
                  children: <Widget>[
                    for (int i = 0; i < chk; i++)
                      Container(
                        width: 150,
                        height: 170,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 150,
                              height: 149,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: DecorationImage(
                                  image: AssetImage('assets/character${i + 1}.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: _isChange
                                  ? IconButton(
                                onPressed: () {
                                  // 버튼 기능 추가 예정
                                },
                                icon: const Icon(Icons.edit, size: 30),
                                color: Colors.white,
                              )
                                  : Container(),
                            ),
                            const Text(
                              "캐릭터",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            const Spacer(), // 빈 공간을 채워 버튼을 아래로 배치
            Padding(
              padding: const EdgeInsets.all(16.0), // 버튼 주위에 여백 추가
              child: SizedBox(
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
                      MaterialPageRoute(
                        builder: (context) => CameraPage(
                          onProfileAdded: _addProfile,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    '프로필 추가하기',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdjustableText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color color;

  const AdjustableText({
    required this.text,
    required this.fontSize,
    this.fontWeight,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color,
      ),
    );
  }
}
