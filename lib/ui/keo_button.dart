import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'keo_theme.dart';

/// Nút chính: cao 56 (>= 48 px chạm), rộng hết khung cha, viền nâu như mẫu.
class KeoButton extends StatelessWidget {
  const KeoButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.color = KeoColors.yellow,
    this.icon = Icons.play_arrow_rounded,
  });

  final String title;
  final VoidCallback onPressed;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 56.h,
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: KeoColors.ink,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.r),
              side: const BorderSide(color: KeoColors.brown, width: 2),
            ),
          ),
          icon: Icon(icon, size: 26.sp),
          label: Text(
            title,
            style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w900),
          ),
        ),
      );
}
