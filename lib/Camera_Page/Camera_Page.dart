import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Camera_Service_Page.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;
import '../providers/camera_provider.dart';

class CameraPage extends StatelessWidget {
  final VoidCallback onProfileAdded;

  const CameraPage({super.key, required this.onProfileAdded});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CameraProvider(),
      child: CameraPageContent(onProfileAdded: onProfileAdded),
    );
  }
}

class CameraPageContent extends StatelessWidget {
  final VoidCallback onProfileAdded;

  const CameraPageContent({super.key, required this.onProfileAdded});

  @override
  Widget build(BuildContext context) {
    final cameraProvider = Provider.of<CameraProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
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
                      if (cameraProvider.videoPlayerController != null &&
                          cameraProvider.videoPlayerController!.value.isInitialized) {
                        if (cameraProvider.videoPlayerController!.value.position ==
                            cameraProvider.videoPlayerController!.value.duration) {
                          cameraProvider.videoPlayerController!.seekTo(Duration.zero);
                          cameraProvider.videoPlayerController!.play();
                        }
                      }
                    },
                    child: cameraProvider.videoPath == null
                        ? Image.asset(
                      'assets/Camera_Page.png',
                      fit: BoxFit.contain,
                    )
                        : cameraProvider.videoPlayerController != null &&
                        cameraProvider.videoPlayerController!.value.isInitialized
                        ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(math.pi),
                      child: AspectRatio(
                        aspectRatio: cameraProvider.videoPlayerController!.value.aspectRatio,
                        child: VideoPlayer(cameraProvider.videoPlayerController!),
                      ),
                    )
                        : Container(),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (cameraProvider.videoPath == null)
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
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CameraServicePage(),
                        ),
                      );

                      if (result != null) {
                        cameraProvider.initializeVideoPlayer(result);
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
              else
                Column(
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
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CameraServicePage(),
                            ),
                          );

                          if (result != null) {
                            cameraProvider.initializeVideoPlayer(result);
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
                          cameraProvider.proceedWithCurrentVideo(context);
                          onProfileAdded();
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
                ),
            ],
          ),
        ),
      ),
    );
  }
}
