import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'camera_service_page.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;
import '../Controllers/Camera_Controller.dart'; // GetX CameraControllerX

class CameraPage extends StatelessWidget {
  final VoidCallback onProfileAdded;

  const CameraPage({super.key, required this.onProfileAdded});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CameraControllerX>(
      init: CameraControllerX(),
      builder: (cameraController) {
        return CameraPageContent(onProfileAdded: onProfileAdded);
      },
    );
  }
}

class CameraPageContent extends StatelessWidget {
  final VoidCallback onProfileAdded;

  const CameraPageContent({super.key, required this.onProfileAdded});

  @override
  Widget build(BuildContext context) {
    final CameraControllerX cameraController = Get.find();

    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF9D0),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '사용자 등록',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                '먼저 사용자 등록을 해야 돼요.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Center(
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: GestureDetector(
                    onTap: () {
                      if (cameraController.videoPlayerController != null &&
                          cameraController.videoPlayerController!.value.isInitialized) {
                        if (cameraController.videoPlayerController!.value.position ==
                            cameraController.videoPlayerController!.value.duration) {
                          cameraController.videoPlayerController!.seekTo(Duration.zero);
                          cameraController.videoPlayerController!.play();
                        }
                      }
                    },
                    child: Obx(() {
                      return cameraController.videoPath.value == null
                          ? Image.asset(
                        'assets/Camera_Page.png',
                        fit: BoxFit.contain,
                      )
                          : cameraController.videoPlayerController != null &&
                          cameraController.videoPlayerController!.value.isInitialized
                          ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateY(math.pi),
                        child: AspectRatio(
                          aspectRatio: cameraController.videoPlayerController!.value.aspectRatio,
                          child: VideoPlayer(cameraController.videoPlayerController!),
                        ),
                      )
                          : Container();
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Obx(() {
                return cameraController.videoPath.value == null
                    ? SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCAF4FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    onPressed: () async {
                      final result = await Get.to(() => CameraServicePage());

                      if (result != null) {
                        cameraController.initializeVideoPlayer(result);
                      }
                    },
                    child: const Text(
                      '카메라 열기',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
                    : Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCAF4FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        onPressed: () async {
                          final result = await Get.to(() => CameraServicePage());

                          if (result != null) {
                            cameraController.initializeVideoPlayer(result);
                          }
                        },
                        child: const Text(
                          '카메라 다시 열기',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCAF4FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        onPressed: () {
                          onProfileAdded();
                          Get.back(result: true); // true 값을 반환하며 페이지를 닫음
                        },
                        child: const Text(
                          '현재 동영상으로 진행',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
