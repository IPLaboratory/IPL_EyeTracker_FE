import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' show join;
import 'package:provider/provider.dart';
import '../Providers/Camera_Provider.dart';
import 'Camera_Overlay.dart';

class CameraServicePage extends StatefulWidget {
  @override
  _CameraServicePageState createState() => _CameraServicePageState();
}

class _CameraServicePageState extends State<CameraServicePage> {
  late CameraController _controller;
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

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: true,
    );

    _initializeControllerFuture = _controller.initialize();
    if (mounted) {
      setState(() {});
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
      print(e);
    }
  }

  Future<void> _stopVideoRecording(BuildContext context) async {
    if (!_controller.value.isRecordingVideo) {
      return;
    }

    try {
      final XFile videoFile = await _controller.stopVideoRecording();
      setState(() {
        _isRecording = false;
      });

      final directory = await getApplicationDocumentsDirectory();
      final String filePath = join(
        directory.path,
        '${DateTime.now()}.mp4',
      );

      await videoFile.saveTo(filePath);

      Provider.of<CameraProvider>(context, listen: false)
          .stopRecording(filePath);

      Navigator.pop(context, filePath);
    } catch (e) {
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
    return ChangeNotifierProvider(
      create: (_) => CameraProvider(),
      child: Scaffold(
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
      ),
    );
  }
}
