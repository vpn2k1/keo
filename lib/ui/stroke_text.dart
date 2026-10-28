import 'package:flutter/material.dart';

import 'keo_theme.dart';

/// Tiêu đề có viền nâu để đọc được trên mọi vùng của ảnh nền.
class StrokeText extends StatelessWidget {
  const StrokeText(
    this.text, {
    super.key,
    required this.size,
    this.color = KeoColors.yellow,
  });

  final String text;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final base = TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w900,
      letterSpacing: size * .03,
      height: 1.1,
    );
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: base.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = size * .13
              ..strokeJoin = StrokeJoin.round
              ..color = KeoColors.brown,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: base.copyWith(
            color: color,
            shadows: const [
              Shadow(
                  offset: Offset(0, 2),
                  blurRadius: 3,
                  color: Color(0x59000000)),
            ],
          ),
        ),
      ],
    );
  }
}
