import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

void showHelpSnackbar(BuildContext context) {
  final snackBar = SnackBar(
    content: AwesomeSnackbarContent(
      title: '도움말',
      message: '연결하기 버튼을 클릭한 뒤 해당 기기의 등록된 기능의 리모컨 스위치를 10초 동안 눌러주세요.',
      contentType: ContentType.help,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
