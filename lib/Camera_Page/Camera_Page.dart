import 'package:flutter/material.dart';
import 'Camera_Service_Page.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;
import '../User_Registration_Page/User_Registration.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  String? _videoPath; // 동영상 경로를 저장하는 변수
  VideoPlayerController? _videoPlayerController;

  void _initializeVideoPlayer(String path) {
    _videoPlayerController = VideoPlayerController.file(File(path))
      ..initialize().then((_) {
        setState(() {}); // 재생 준비가 완료되면 화면을 다시 그립니다.
        _videoPlayerController!.play(); // 자동으로 재생

        // 동영상 재생이 끝났을 때의 리스너 추가
        _videoPlayerController!.addListener(() {
          if (_videoPlayerController!.value.position == _videoPlayerController!.value.duration) {
            setState(() {}); // 재생이 끝났을 때 화면을 다시 그립니다.
          }
        });
      });
  }

  void _proceedWithCurrentVideo() {
    // 현재 동영상으로 진행하는 기능을 구현합니다.
    // UserRegistrationPage로 이동합니다.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserRegistrationPage()),
    );
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    if (_videoPlayerController != null && _videoPlayerController!.value.isInitialized) {
                      if (_videoPlayerController!.value.position == _videoPlayerController!.value.duration) {
                        _videoPlayerController!.seekTo(Duration.zero);
                        _videoPlayerController!.play();
                      }
                    }
                  },
                  child: _videoPath == null
                      ? Image.asset(
                    'assets/Camera_Page.png', // 사용할 일러스트 경로
                    fit: BoxFit.contain,
                  )
                      : _videoPlayerController != null && _videoPlayerController!.value.isInitialized
                      ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(math.pi),
                    child: AspectRatio(
                      aspectRatio: _videoPlayerController!.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController!),
                    ),
                  )
                      : Container(),
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (_videoPath == null)
              SizedBox(
                width: double.infinity, // 버튼을 화면 너비에 꽉 채우도록 설정
                height: 50, // 버튼 높이 설정
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCAF4FF), // 버튼 배경색 설정
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0), // TextField와 동일한 둥근 모서리
                    ),
                  ),
                  onPressed: () async {
                    // CameraServicePage로 이동하는 코드
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CameraServicePage(),
                      ),
                    );

                    if (result != null) {
                      setState(() {
                        _videoPath = result;
                        _initializeVideoPlayer(_videoPath!);
                      });
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
                    width: double.infinity, // 버튼을 화면 너비에 꽉 채우도록 설정
                    height: 50, // 버튼 높이 설정
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCAF4FF), // 버튼 배경색 설정
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0), // TextField와 동일한 둥근 모서리
                        ),
                      ),
                      onPressed: () async {
                        // CameraServicePage로 이동하는 코드
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CameraServicePage(),
                          ),
                        );

                        if (result != null) {
                          setState(() {
                            _videoPath = result;
                            _initializeVideoPlayer(_videoPath!);
                          });
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
                    width: double.infinity, // 버튼을 화면 너비에 꽉 채우도록 설정
                    height: 50, // 버튼 높이 설정
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCAF4FF), // 버튼 배경색 설정
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0), // TextField와 동일한 둥근 모서리
                        ),
                      ),
                      onPressed: _proceedWithCurrentVideo,
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
    );
  }
}
