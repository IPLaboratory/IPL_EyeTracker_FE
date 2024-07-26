import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class CameraPageController extends GetxController {
  var videoPath = Rx<String?>(null);
  VideoPlayerController? videoPlayerController;

  void initializeVideoPlayer(String path) {
    videoPath.value = path;
    videoPlayerController = VideoPlayerController.file(File(path))
      ..initialize().then((_) {
        videoPlayerController!.play();
        update();
      });
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    super.onClose();
  }
}