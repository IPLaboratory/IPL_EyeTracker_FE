import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // SVG 파일 사용을 위한 패키지
import '../Camera_Page/Camera_Page.dart';  // CameraPage 파일 임포트
import '../User_Registration_Page/User_Registration.dart'; // UserRegistrationPage 파일 임포트
import 'Change_Profile.dart'; //Change_ProfilePage 파일 임포트
import '../Device_Select_Page/Main_Device.dart'; //Main_Device파일 임포트


class MainProfilePage extends StatefulWidget {
  const MainProfilePage({super.key});

  @override
  _MainProfilePageState createState() => _MainProfilePageState();
}

class _MainProfilePageState extends State<MainProfilePage> {
  bool _isImageVisible = true;
  bool _isChange = false;
  int chk = 0;

  void addProfile() {
    setState(() {
      _isImageVisible = false;
      chk += 1;
    });
  }

  void navigateToUserRegistrationPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserRegistrationPage()),
    );
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
              // color 속성을 사용하지 않음, 기본 색상 유지
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
          mainAxisAlignment: MainAxisAlignment.start, // 텍스트를 위쪽에 배치
          children: [
            const SizedBox(height: 5), // 원하는 높이로 조절 가능
            const AdjustableText(
              text: 'E.T.',
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            const SizedBox(height: 14),
            const AdjustableText(
              text: '아이트랙킹할 프로필을 추가해주세요.',
              fontSize: 20,
              color: Colors.black,
            ),
            //이미지 표시 여부에 따라 이미지 위젯을 조건부 렌더링
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
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Wrap(
                  spacing: 20.0, // 자식 요소 간의 수평 간격
                  runSpacing: 20.0, // 자식 요소 간의 수직 간격
                  children: List.generate(chk, (index) {
                    return GestureDetector(
                      onTap: () => navigateToUserRegistrationPage(context),
                      child: Container(
                        width: 150,
                        height: 170,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 130,
                              height: 129,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: DecorationImage(
                                  image: AssetImage('assets/character${index + 1}.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: _isChange
                                  ? IconButton(
                                onPressed: () {
                                  // 버튼 기능 추가 예정
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ChangeProfilePage()),
                                  );
                                },
                                icon: const Icon(Icons.edit, size: 30),
                                color: Colors.white,
                              )
                                  : Container(), // _isChange가 false일 때 빈 컨테이너를 표시
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("캐릭터${index + 1}", textAlign: TextAlign.center)
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
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
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CameraPage(onProfileAdded: addProfile),
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
            Padding(
              padding: const EdgeInsets.all(16.0), // 버튼 주위에 여백 추가
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF48859E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  onPressed: () {
                    //profileProvider.profile(context);
                    //ChangeProfilePage();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MainDevicePage()),
                    );
                  },
                  child: const Text(
                    '기기 선택',
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
