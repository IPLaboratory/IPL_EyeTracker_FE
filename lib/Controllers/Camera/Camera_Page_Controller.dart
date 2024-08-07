import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 패키지 추가
import 'package:real_test/Controllers/Login/Login_Controller.dart'; // LoginController를 가져오는 경로는 실제 경로에 맞게 수정하세요

class CameraPageController extends GetxController {
  var videoPath = Rx<String?>(null);
  String? secondVideoPath; // 두 번째 영상 경로 추가
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
      final url = dotenv.env['ADD_MEMBER_URL1'] ?? ''; // .env 파일에서 ADD_MEMBER_URL1 가져오기

      if (url.isEmpty) {
        Get.snackbar('실패', 'ADD_MEMBER_URL1이 설정되지 않았습니다.');
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
      var responseData = await http.Response.fromStream(response);
      print('서버 응답: ${responseData.statusCode}'); // 상태 코드 로그 출력
      print('서버 응답 본문: ${responseData.body}'); // 응답 본문 로그 출력

      if (response.statusCode == 200) {
        Get.snackbar('성공', '비디오 업로드 성공');
        Get.toNamed('/mainProfile'); // 경로 이름 사용
      } else {
        var responseBody = jsonDecode(responseData.body);
        Get.snackbar('실패', responseBody['message'] ?? '비디오 업로드 실패');
      }
    }
  }

  Future<void> uploadTwoVideos(String name) async {
    if (videoPath.value != null && secondVideoPath != null) {
      final url1 = dotenv.env['ADD_MEMBER_URL1'] ?? ''; // .env 파일에서 ADD_MEMBER_URL1 가져오기
      final url2 = dotenv.env['ADD_MEMBER_URL2'] ?? ''; // .env 파일에서 ADD_MEMBER_URL2 가져오기

      if (url1.isEmpty || url2.isEmpty) {
        Get.snackbar('실패', 'ADD_MEMBER_URL1 또는 ADD_MEMBER_URL2가 설정되지 않았습니다.');
        return;
      }

      // 첫 번째 비디오 업로드
      var request1 = http.MultipartRequest(
        'POST',
        Uri.parse(url1), // 서버의 첫 번째 API 엔드포인트로 변경하세요
      );
      request1.fields['homeId'] = loginController.homeId.value.toString(); // homeId를 롱 값으로 전송
      request1.fields['name'] = name; // 사용자 이름을 스트링 값으로 전송
      request1.files.add(await http.MultipartFile.fromPath('video', videoPath.value!));

      var response1 = await request1.send();
      var responseData1 = await http.Response.fromStream(response1);
      print('첫 번째 비디오 서버 응답: ${responseData1.statusCode}'); // 상태 코드 로그 출력
      print('첫 번째 비디오 서버 응답 본문: ${responseData1.body}'); // 응답 본문 로그 출력

      if (response1.statusCode == 200) {
        var responseJson1 = jsonDecode(responseData1.body);
        int memberId = responseJson1['data']['id']; // 첫 번째 응답에서 memberId 추출

        // 두 번째 비디오 파일 경로 확인
        if (!File(secondVideoPath!).existsSync()) {
          print('두 번째 비디오 파일이 존재하지 않습니다: $secondVideoPath');
          Get.snackbar('실패', '두 번째 비디오 파일이 존재하지 않습니다.');
          return;
        }

        print('두 번째 비디오 파일 경로: $secondVideoPath');

        // 두 번째 비디오 파일 읽기
        var secondVideoFile = File(secondVideoPath!);
        var secondVideoFileSize = await secondVideoFile.length();
        print('두 번째 비디오 파일 크기: $secondVideoFileSize 바이트');

        // 두 번째 비디오 업로드
        var request2 = http.MultipartRequest(
          'POST',
          Uri.parse(url2), // 서버의 두 번째 API 엔드포인트로 변경하세요
        );
        request2.fields['memberId'] = memberId.toString(); // memberId를 스트링 값으로 전송
        request2.files.add(await http.MultipartFile.fromPath('video2', secondVideoPath!)); // 'video2'로 변경

        var response2 = await request2.send();
        var responseData2 = await http.Response.fromStream(response2);
        print('두 번째 비디오 서버 응답: ${responseData2.statusCode}'); // 상태 코드 로그 출력
        print('두 번째 비디오 서버 응답 본문: ${responseData2.body}'); // 응답 본문 로그 출력

        if (response2.statusCode == 200) {
          Get.snackbar('성공', '두 번째 비디오 업로드 성공');
          Get.toNamed('/mainProfile'); // 경로 이름 사용
        } else {
          var responseBody = jsonDecode(responseData2.body);
          Get.snackbar('실패', responseBody['message'] ?? '두 번째 비디오 업로드 실패');
        }
      } else {
        var responseBody = jsonDecode(responseData1.body);
        Get.snackbar('실패', responseBody['message'] ?? '첫 번째 비디오 업로드 실패');
        return; // 첫 번째 업로드가 실패하면 중단
      }
    } else {
      if (videoPath.value == null) {
        Get.snackbar('실패', '첫 번째 비디오 경로가 설정되지 않았습니다.');
      }
      if (secondVideoPath == null) {
        Get.snackbar('실패', '두 번째 비디오 경로가 설정되지 않았습니다.');
      }
    }
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    super.onClose();
  }
}
