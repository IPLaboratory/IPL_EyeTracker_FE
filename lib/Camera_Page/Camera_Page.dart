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
                  return Column(
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
                            '카메라 열기',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '상, 하, 좌, 우 중앙을 2초씩 바라봐주세요.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
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
                          onPressed: () {
                            _showOptionDialog(context, nameController.text, cameraController);
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

  void _showOptionDialog(BuildContext context, String name, CameraPageController cameraController) {
    Get.dialog(
      AlertDialog(
        title: const Center(
          child: Text(
            '안경을 쓰셨나요?\n안경을 쓰셨다면 벗고 다시 찍어주세요.',
            style: TextStyle(
              fontSize: 15, // 텍스트 크기 조절
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () async {
                  // '네' 버튼 클릭 시 동작 추가
                  final result = await Get.to(() => CameraServicePage());

                  if (result != null) {
                    cameraController.secondVideoPath = result;

                    // 로딩 창 표시
                    _showLoadingDialog();

                    await cameraController.uploadTwoVideos(name);

                    // 로딩 창 닫기
                    Get.back();

                    onProfileAdded(); // 페이지를 닫기 전에 프로필 추가 콜백 호출
                    Get.offNamedUntil('/mainProfile', ModalRoute.withName('/home')); // 로그인 페이지를 남기고 스택을 지우고 프로필 페이지로 이동
                  }
                },
                child: const Text(
                  '네',
                  style: TextStyle(
                    fontSize: 18, // 텍스트 크기 조절
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  // '아니오' 버튼 클릭 시 동작 추가

                  // 로딩 창 표시
                  _showLoadingDialog();

                  await cameraController.uploadVideo(name);

                  // 로딩 창 닫기
                  Get.back();

                  onProfileAdded(); // 페이지를 닫기 전에 프로필 추가 콜백 호출
                  Get.offNamedUntil('/mainProfile', ModalRoute.withName('/home')); // 로그인 페이지를 남기고 스택을 지우고 프로필 페이지로 이동
                },
                child: const Text(
                  '아니요',
                  style: TextStyle(
                    fontSize: 18, // 텍스트 크기 조절
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLoadingDialog() {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false, // 로딩 중에는 창을 닫을 수 없도록 설정
    );
  }
}
