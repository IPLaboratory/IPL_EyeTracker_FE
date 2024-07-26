import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' show join;
import 'package:get/get.dart';
import '../Controllers/Camera_Controller.dart'; // GetX CameraControllerX
import 'Camera_Overlay.dart';

class CameraServicePage extends StatefulWidget {
  @override
  _CameraServicePageState createState() => _CameraServicePageState();
}

class _CameraServicePageState extends State<CameraServicePage> {
  late CameraController _cameraController; // camera 패키지의 CameraController
  Future<void>? _initializeControllerFuture;
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

    _cameraController = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: true,
    );

    _initializeControllerFuture = _cameraController.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _startVideoRecording() async {
    if (_cameraController.value.isRecordingVideo) {
      return;
    }

    try {
      await _initializeControllerFuture;
      await _cameraController.startVideoRecording();
      setState(() {
        _isRecording = true;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _stopVideoRecording(BuildContext context) async {
    if (!_cameraController.value.isRecordingVideo) {
      return;
    }

    try {
      final XFile videoFile = await _cameraController.stopVideoRecording();
      setState(() {
        _isRecording = false;
      });

      final directory = await getApplicationDocumentsDirectory();
      final String filePath = join(
        directory.path,
        '${DateTime.now()}.mp4',
      );

      await videoFile.saveTo(filePath);

      // Use GetX to update the camera controller
      final CameraControllerX cameraControllerX = Get.find();
      cameraControllerX.stopRecording(filePath);

      Get.back(result: filePath);
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
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
                CameraPreview(_cameraController),
                CameraOverlay(
                  onStartRecording: _startVideoRecording,
                  onStopRecording: () => _stopVideoRecording(context),
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
