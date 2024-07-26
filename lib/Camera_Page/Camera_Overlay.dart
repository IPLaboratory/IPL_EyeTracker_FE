import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/Camera/camera_overlay_controller.dart';

class CameraOverlay extends StatelessWidget {
  final VoidCallback onStartRecording;
  final VoidCallback onStopRecording;

  CameraOverlay({
    required this.onStartRecording,
    required this.onStopRecording,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CameraOverlayController>(
      init: CameraOverlayController(),
      builder: (controller) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      heroTag: 'startRecording',  // Unique hero tag
                      onPressed: controller.isRecording.value ? null : onStartRecording,
                      backgroundColor: controller.isRecording.value ? Colors.grey : Colors.red,
                      child: Icon(Icons.videocam),
                    ),
                    SizedBox(width: 15),
                    FloatingActionButton(
                      heroTag: 'stopRecording',  // Unique hero tag
                      onPressed: controller.isRecording.value ? onStopRecording : null,
                      backgroundColor: controller.isRecording.value ? Colors.red : Colors.grey,
                      child: Icon(Icons.stop),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Image.asset(
                'assets/Camera_Overlay_Icon.png',
                width: 300, // 원하는 크기로 설정
                height: 400, // 원하는 크기로 설정
                fit: BoxFit.contain,
              ),
            ),
          ],
        );
      },
    );
  }
}