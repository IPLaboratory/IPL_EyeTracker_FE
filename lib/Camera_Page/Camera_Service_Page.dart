import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' show join;
import 'Camera_Overlay.dart';

class CameraServicePage extends StatefulWidget {
  @override
  _CameraServicePageState createState() => _CameraServicePageState();
}

class _CameraServicePageState extends State<CameraServicePage> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture; // 초기값을 null로 설정
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: true,
    );

    _initializeControllerFuture = _controller.initialize();
    if (mounted) {
      setState(() {}); // 카메라 초기화가 완료되면 화면을 다시 그립니다.
    }
  }

  Future<void> _startVideoRecording() async {
    if (_controller.value.isRecordingVideo) {
      return;
    }

    try {
      await _initializeControllerFuture;
      await _controller.startVideoRecording();
      setState(() {
        _isRecording = true;
      });
    } catch (e) {
      // 오류 처리
      print(e);
    }
  }

  Future<void> _stopVideoRecording() async {
    if (!_controller.value.isRecordingVideo) {
      return;
    }

    try {
      final XFile videoFile = await _controller.stopVideoRecording();
      setState(() {
        _isRecording = false;
      });

      // 동영상을 저장할 경로를 생성합니다.
      final directory = await getApplicationDocumentsDirectory();
      final String filePath = join(
        directory.path,
        '${DateTime.now()}.mp4',
      );

      // 파일을 지정된 경로로 저장합니다.
      await videoFile.saveTo(filePath);

      // 파일 경로를 반환하고 페이지를 종료합니다.
      Navigator.pop(context, filePath);
    } catch (e) {
      // 오류 처리
      print(e);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _initializeControllerFuture == null
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                CameraPreview(_controller),
                CameraOverlay(
                  onStartRecording: _startVideoRecording,
                  onStopRecording: _stopVideoRecording,
                  isRecording: _isRecording,
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
