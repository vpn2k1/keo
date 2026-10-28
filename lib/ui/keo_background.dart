import 'package:flutter/material.dart';

/// Ảnh nền phủ kín màn hình, tối dần ở đáy để nút và chữ nổi lên.
class KeoBackground extends StatelessWidget {
  const KeoBackground({super.key, required this.child, this.image = 'menu'});

  final Widget child;
  final String image;

  @override
  Widget build(BuildContext context) => Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/$image.png',
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, .5, 1],
                colors: [
                  Color(0x00000000),
                  Color(0x1A000000),
                  Color(0x5E000000)
                ],
              ),
            ),
          ),
          SafeArea(child: child),
        ],
      );
}
