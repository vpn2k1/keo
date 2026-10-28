import 'package:flutter/material.dart';

import '../ui/keo_ui.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool left = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1600), _goHome);
  }

  // Splash nằm trên trang chủ trong stack, nên đóng lại là về đúng trang chủ.
  void _goHome() {
    if (!mounted || left) return;
    left = true;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: GestureDetector(
          onTap: _goHome,
          // Chữ đặt ở dải trời phía trên để không che nhân vật trong title.png.
          child: KeoBackground(
            image: 'title',
            child: Column(
              children: [
                const SizedBox(height: 18),
                const StrokeText('KEO', size: 72),
                const SizedBox(height: 8),
                const KeoPanel(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                  child: Text(
                    'VƯỢT PHÒNG TUYẾN',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      color: KeoColors.ink,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const Spacer(),
                const Text(
                  'Chạm để bắt đầu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    shadows: [Shadow(blurRadius: 6, color: Colors.black)],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      );
}
