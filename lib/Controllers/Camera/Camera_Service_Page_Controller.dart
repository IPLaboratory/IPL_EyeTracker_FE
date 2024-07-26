import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' show join;
import 'camera_overlay_controller.dart';

class CameraServicePageController extends GetxController {
  late CameraController cameraController;
  Future<void>? initializeControllerFuture;
  final CameraOverlayController overlayController = Get.put(CameraOverlayController());

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    cameraController = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: true,
    );

    initializeControllerFuture = cameraController.initialize();
    update();
  }

  Future<void> startVideoRecording() async {
    if (cameraController.value.isRecordingVideo) {
      return;
    }

    try {
      await initializeControllerFuture;
      await cameraController.startVideoRecording();
      overlayController.startRecording();
      update();
    } catch (e) {
      print(e);
    }
  }

  Future<void> stopVideoRecording() async {
    if (!cameraController.value.isRecordingVideo) {
      return;
    }

    try {
      final XFile videoFile = await cameraController.stopVideoRecording();
      overlayController.stopRecording();
      update();

      final directory = await getApplicationDocumentsDirectory();
      final String filePath = join(
        directory.path,
        '${DateTime.now()}.mp4',
      );

      await videoFile.saveTo(filePath);

      Get.back(result: filePath);
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}