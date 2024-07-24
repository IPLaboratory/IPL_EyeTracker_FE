import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

void showRegistrationInProgress(BuildContext context) {
  final snackBar = SnackBar(
    content: AwesomeSnackbarContent(
      title: '등록 중!',
      message: '현재 주파수를 등록 중입니다. 계속해서 리모콘을 눌러주세요.',
      contentType: ContentType.help,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showRegistrationComplete(BuildContext context) {
  final snackBar = SnackBar(
    content: AwesomeSnackbarContent(
      title: '등록 완료!',
      message: '주파수가 등록되었습니다!',
      contentType: ContentType.success,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
