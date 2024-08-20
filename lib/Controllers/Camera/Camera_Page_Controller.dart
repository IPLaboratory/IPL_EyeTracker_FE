import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:real_test/Controllers/Login/Login_Controller.dart';

class CameraPageController extends GetxController {
  var videoPath = Rx<String?>(null);
  String? secondVideoPath;
  VideoPlayerController? videoPlayerController;
  final LoginController loginController = Get.find();

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
      final url = dotenv.env['ADD_MEMBER_URL1'] ?? '';

      if (url.isEmpty) {
        Get.snackbar('실패', 'ADD_MEMBER_URL1이 설정되지 않았습니다.');
        return;
      }

      print('요청 URL: $url');

      File videoFile = File(videoPath.value!);
      int chunkSize = 1024 * 1536; // 1.5MB로 쪼개기
      List<int> videoBytes = videoFile.readAsBytesSync();
      String base64Video = base64Encode(videoBytes); // 전체 파일을 base64로 인코딩
      int totalChunks = (base64Video.length / chunkSize).ceil();

      print('비디오 파일 크기: ${videoFile.lengthSync()} bytes');
      print('Base64 인코딩 후 길이: ${base64Video.length}');
      print('총 청크 수: $totalChunks');

      for (int i = 0; i < totalChunks; i++) {
        int start = i * chunkSize;
        int end = start + chunkSize;
        if (end > base64Video.length) end = base64Video.length;

        String base64Chunk = base64Video.substring(start, end);
        print('청크 $i: 시작 위치 = $start, 끝 위치 = $end');

        var request = http.MultipartRequest('POST', Uri.parse(url));
        request.fields['homeId'] = loginController.homeId.value.toString();
        request.fields['name'] = name;
        request.fields['videoChunk'] = base64Chunk;
        request.fields['chunkIndex'] = i.toString();
        request.fields['totalChunks'] = totalChunks.toString();

        print('서버로 전송 중: 청크 $i / $totalChunks');

        var response = await request.send();
        var responseData = await http.Response.fromStream(response);
        print('서버 응답 상태 코드: ${responseData.statusCode}');
        print('서버 응답 본문: ${responseData.body}');

        if (response.statusCode != 200) {
          var responseBody = jsonDecode(responseData.body);
          print('비디오 업로드 실패: ${responseBody['message'] ?? '알 수 없는 오류'}');
          Get.snackbar('실패', responseBody['message'] ?? '비디오 업로드 실패');
          return;
        }
      }

      print('비디오 업로드 성공');
      Get.snackbar('성공', '비디오 업로드 성공');
      Get.toNamed('/mainProfile');
    }
  }

  Future<void> uploadTwoVideos(String name) async {
    if (videoPath.value != null && secondVideoPath != null) {
      final url1 = dotenv.env['ADD_MEMBER_URL1'] ?? '';
      final url2 = dotenv.env['ADD_MEMBER_URL2'] ?? '';

      if (url1.isEmpty || url2.isEmpty) {
        Get.snackbar('실패', 'ADD_MEMBER_URL1 또는 ADD_MEMBER_URL2가 설정되지 않았습니다.');
        return;
      }

      print('첫 번째 요청 URL: $url1');

      // 첫 번째 비디오 업로드
      File videoFile = File(videoPath.value!);
      int chunkSize = 1024 * 1536; // 1.5MB로 쪼개기
      List<int> videoBytes = videoFile.readAsBytesSync();
      String base64Video = base64Encode(videoBytes);
      int totalChunks = (base64Video.length / chunkSize).ceil();

      print('첫 번째 비디오 파일 크기: ${videoFile.lengthSync()} bytes');
      print('첫 번째 Base64 인코딩 후 길이: ${base64Video.length}');
      print('총 청크 수: $totalChunks');

      int memberId = -1;
      for (int i = 0; i < totalChunks; i++) {
        int start = i * chunkSize;
        int end = start + chunkSize;
        if (end > base64Video.length) end = base64Video.length;

        String base64Chunk = base64Video.substring(start, end);
        print('청크 $i: 시작 위치 = $start, 끝 위치 = $end');

        var request = http.MultipartRequest('POST', Uri.parse(url1));
        request.fields['homeId'] = loginController.homeId.value.toString();
        request.fields['name'] = name;
        request.fields['videoChunk'] = base64Chunk;
        request.fields['chunkIndex'] = i.toString();
        request.fields['totalChunks'] = totalChunks.toString();

        print('첫 번째 비디오 서버로 전송 중: 청크 $i / $totalChunks');

        var response = await request.send();
        var responseData = await http.Response.fromStream(response);
        print('첫 번째 비디오 서버 응답 상태 코드: ${responseData.statusCode}');
        print('첫 번째 비디오 서버 응답 본문: ${responseData.body}');

        if (response.statusCode != 200) {
          var responseBody = jsonDecode(responseData.body);
          print('첫 번째 비디오 업로드 실패: ${responseBody['message'] ?? '알 수 없는 오류'}');
          Get.snackbar('실패', responseBody['message'] ?? '첫 번째 비디오 업로드 실패');
          return;
        } else if (i == totalChunks - 1) {
          var responseJson = jsonDecode(responseData.body);
          memberId = responseJson['data']['id'];
          print('서버에서 받은 memberId: $memberId');
        }
      }

      // 두 번째 비디오 업로드
      print('두 번째 요청 URL: $url2');

      File secondVideoFile = File(secondVideoPath!);
      List<int> secondVideoBytes = secondVideoFile.readAsBytesSync();
      String base64SecondVideo = base64Encode(secondVideoBytes);
      int secondTotalChunks = (base64SecondVideo.length / chunkSize).ceil();

      print('두 번째 비디오 파일 크기: ${secondVideoFile.lengthSync()} bytes');
      print('두 번째 Base64 인코딩 후 길이: ${base64SecondVideo.length}');
      print('총 청크 수: $secondTotalChunks');

      for (int i = 0; i < secondTotalChunks; i++) {
        int start = i * chunkSize;
        int end = start + chunkSize;
        if (end > base64SecondVideo.length) end = base64SecondVideo.length;

        String base64Chunk = base64SecondVideo.substring(start, end);
        print('청크 $i: 시작 위치 = $start, 끝 위치 = $end');

        var request2 = http.MultipartRequest('POST', Uri.parse(url2));
        request2.fields['memberId'] = memberId.toString();
        request2.fields['videoChunk'] = base64Chunk;
        request2.fields['chunkIndex'] = i.toString();
        request2.fields['totalChunks'] = secondTotalChunks.toString();

        print('두 번째 비디오 서버로 전송 중: 청크 $i / $secondTotalChunks');

        var response2 = await request2.send();
        var responseData2 = await http.Response.fromStream(response2);
        print('두 번째 비디오 서버 응답 상태 코드: ${responseData2.statusCode}');
        print('두 번째 비디오 서버 응답 본문: ${responseData2.body}');

        if (response2.statusCode != 200) {
          var responseBody = jsonDecode(responseData2.body);
          print('두 번째 비디오 업로드 실패: ${responseBody['message'] ?? '알 수 없는 오류'}');
          Get.snackbar('실패', responseBody['message'] ?? '두 번째 비디오 업로드 실패');
          return;
        }
      }

      print('두 번째 비디오 업로드 성공');
      Get.snackbar('성공', '두 번째 비디오 업로드 성공');
      Get.toNamed('/mainProfile');
    } else {
      if (videoPath.value == null) {
        print('첫 번째 비디오 경로가 설정되지 않았습니다.');
        Get.snackbar('실패', '첫 번째 비디오 경로가 설정되지 않았습니다.');
      }
      if (secondVideoPath == null) {
        print('두 번째 비디오 경로가 설정되지 않았습니다.');
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
