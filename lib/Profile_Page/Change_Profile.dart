import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:real_test/Profile_Page/Main_Profile.dart';


class ChangeProfilePage extends StatefulWidget {
  const ChangeProfilePage({super.key});

  @override
  _ChangeProfilePageState createState() => _ChangeProfilePageState();
}

class _ChangeProfilePageState extends State<ChangeProfilePage>{

  XFile? selectedImage; //이미지를 담을 변수 선언
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화

  //이미지를 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        selectedImage = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFF9D0), // 배경색 설정
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFF9D0),
          //backgroundColor: const Color(0xFFFFd9D0),// 배경색 설정
          elevation: 0, // 그림자 제거
          actions: [
            const SizedBox(width: 10), // 약간의 간격 추가
          ],
        ),
        body:Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 5),
              const AdjustableText(
                  text: 'E.T',
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
              color: Colors.black,
              ),
              const SizedBox(height: 14),
              const AdjustableText(
                text: '자유롭게 프로필을 수정하세요.',
                fontSize: 20,
                color: Colors.black,
              ),
              const SizedBox(height: 60),
              Stack(
                children: [
                  if(selectedImage==null)
                    Container(
                      width: 150,
                      height: 149,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(
                          image: AssetImage('assets/character1.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  if(selectedImage!=null)
                    Container(
                      width: 150,
                      height: 149,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(
                          image: FileImage(File(selectedImage!.path)),
                          /*image: AssetImage(
                        selectedImage!.path,
                      ),*/
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      },
                      icon: Icon(Icons.edit, size: 25,),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '캐릭터1',
                        ),
                      ),
                    ],
                  )
              ),
              const Spacer(),// 빈 공간을 채워 버튼을 아래로 배치
              Padding(
                padding: const EdgeInsets.all(16.0),// 버튼 주위에 여백 추가
                child: Column(
                  children: [
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
                        },
                        child: const Text(
                          '저장',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
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
