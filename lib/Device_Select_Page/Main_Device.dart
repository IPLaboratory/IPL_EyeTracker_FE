import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/Device/Main_Device_Controller.dart';

class MainDevicePage extends StatelessWidget {
  final MainDeviceController controller = Get.put(MainDeviceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9D0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF9D0),
        elevation: 0,
        actions: [
          const SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              'E.T.',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 0),
            const Text(
              '기기를 연결중이에요. 조금만 기다려주세요',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Center(
              child: SizedBox(
                width: 300,
                height: 300,
                child: Image.asset(
                  'assets/Device.gif',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Text(
              '사용자의 눈을 아이트래킹 중입니다 ···',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
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
                    controller.stopEyeTracking();
                  },
                  child: const Text(
                    '아이트래킹 종료하기',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
