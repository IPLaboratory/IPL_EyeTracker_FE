import 'dart:io';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class CameraControllerX extends GetxController { // Renamed to avoid conflict
  var videoPath = Rx<String?>(null);
  VideoPlayerController? videoPlayerController;
  var isRecording = false.obs;

  void initializeVideoPlayer(String path) {
    // 비디오 플레이어를 초기화하기 전에 이전 비디오 플레이어 리소스를 해제합니다.
    videoPlayerController?.dispose();
    videoPlayerController = null;

    videoPath.value = path;
    videoPlayerController = VideoPlayerController.file(File(path))
      ..initialize().then((_) {
        videoPlayerController!.play();
        update();
      }).catchError((error) {
        print('Error initializing video player: $error');
      });
  }

  void startRecording() {
    isRecording.value = true;
  }

  void stopRecording(String path) {
    isRecording.value = false;
    initializeVideoPlayer(path);
  }

  void proceedWithCurrentVideo() {
    Get.back();
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    super.dispose();
  }
}
