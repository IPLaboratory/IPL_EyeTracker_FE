import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'camera_service_page.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;
import 'package:real_test/Controllers/Camera/Camera_Page_Controller.dart';

class CameraPage extends StatelessWidget {
  final VoidCallback onProfileAdded;

  const CameraPage({super.key, required this.onProfileAdded});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CameraPageController>(
      init: CameraPageController(),
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
    final CameraPageController cameraController = Get.find();
    final TextEditingController nameController = TextEditingController();

    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF9D0),
        body: SingleChildScrollView(
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
                if (cameraController.videoPath.value == null) {
                  return SizedBox(
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
                  );
                } else {
                  return Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: '이름 입력',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 24),
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
                            final name = nameController.text;
                            if (name.isNotEmpty) {
                              await cameraController.uploadVideo(name);
                              onProfileAdded();
                              Get.back(result: true); // true 값을 반환하며 페이지를 닫음
                            } else {
                              Get.snackbar('실패', '이름을 입력해주세요.');
                            }
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
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
