import 'package:flutter/material.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';
import '../User_Registration_Page/User_Registration.dart'; // 경로는 실제 경로에 맞게 조정하세요

class CameraProvider with ChangeNotifier {
  String? _videoPath;
  VideoPlayerController? _videoPlayerController;
  bool _isRecording = false;

  String? get videoPath => _videoPath;
  VideoPlayerController? get videoPlayerController => _videoPlayerController;
  bool get isRecording => _isRecording;

  void initializeVideoPlayer(String path) {
    // 비디오 플레이어를 초기화하기 전에 이전 비디오 플레이어 리소스를 해제합니다.
    _videoPlayerController?.dispose();
    _videoPlayerController = null;

    _videoPath = path;
    _videoPlayerController = VideoPlayerController.file(File(path))
      ..initialize().then((_) {
        _videoPlayerController!.play();
        notifyListeners();
      }).catchError((error) {
        print('Error initializing video player: $error');
      });
  }

  void startRecording() {
    _isRecording = true;
    notifyListeners();
  }

  void stopRecording(String path) {
    _isRecording = false;
    initializeVideoPlayer(path);
    notifyListeners();
  }

  void proceedWithCurrentVideo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserRegistrationPage()),
    );
  }

  void disposeVideoPlayer() {
    _videoPlayerController?.dispose();
    _videoPlayerController = null;
  }
}
