import 'package:flutter/material.dart';

class CameraOverlay extends StatelessWidget {
  final VoidCallback onStartRecording;
  final VoidCallback onStopRecording;
  final bool isRecording;

  CameraOverlay({
    required this.onStartRecording,
    required this.onStopRecording,
    required this.isRecording,
  });

  @override
  Widget build(BuildContext context) {
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
                  onPressed: isRecording ? null : onStartRecording,
                  backgroundColor: isRecording ? Colors.grey : Colors.red,
                  child: Icon(Icons.videocam),
                ),
                SizedBox(width: 15),
                FloatingActionButton(
                  onPressed: isRecording ? onStopRecording : null,
                  backgroundColor: isRecording ? Colors.red : Colors.grey,
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
  }
}
