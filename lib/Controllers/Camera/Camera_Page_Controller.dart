import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 패키지 추가
import 'package:real_test/Controllers/Login/Login_Controller.dart'; // LoginController를 가져오는 경로는 실제 경로에 맞게 수정하세요

class CameraPageController extends GetxController {
  var videoPath = Rx<String?>(null);
  VideoPlayerController? videoPlayerController;
  final LoginController loginController = Get.find(); // LoginController 인스턴스 가져오기

  void initializeVideoPlayer(String path) {
    videoPath.value = path;
    videoPlayerController = VideoPlayerController.file(File(path))
      ..initialize().then((_) {
        videoPlayerController!.play();
        update();
      });
  }

  Future<void> uploadVideo(String name) async {
    if (videoPath.value != null) {
/*      final url = dotenv.env['ADD_MEMBER_URL'] ?? ''; // .env 파일에서 ADD_MEMBER_URL 가져오기

      if (url.isEmpty) {
        Get.snackbar('실패', 'ADD_MEMBER_URL이 설정되지 않았습니다.');
        return;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url), // 서버의 API 엔드포인트로 변경하세요
      );
      request.fields['homeId'] = loginController.homeId.value.toString(); // homeId를 롱 값으로 전송
      request.fields['name'] = name; // 사용자 이름을 스트링 값으로 전송
      request.files.add(await http.MultipartFile.fromPath('video', videoPath.value!));

      var response = await request.send();
      if (response.statusCode == 200) {
        Get.snackbar('성공', '비디오 업로드 성공');
        Get.toNamed('/mainProfile'); // 경로 이름 사용
      } else {
        var responseData = await http.Response.fromStream(response);
        var responseBody = jsonDecode(responseData.body);
        Get.snackbar('실패', responseBody['message'] ?? '비디오 업로드 실패');
      }*/
    }
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    super.onClose();
  }
}
