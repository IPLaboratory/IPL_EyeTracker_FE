import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import '../Controllers/Camera/camera_service_page_controller.dart';
import 'camera_overlay.dart';

class CameraServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CameraServicePageController>(
      init: CameraServicePageController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: FutureBuilder<void>(
            future: controller.initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: [
                    GetBuilder<CameraServicePageController>(
                      builder: (_) {
                        if (controller.cameraController != null &&
                            controller.cameraController.value.isInitialized) {
                          return CameraPreview(controller.cameraController);
                        } else {
                          return Center(child: Text('Camera is not initialized'));
                        }
                      },
                    ),
                    CameraOverlay(
                      onStartRecording: controller.startVideoRecording,
                      onStopRecording: controller.stopVideoRecording,
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        );
      },
    );
  }
}