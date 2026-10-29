import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'keo_theme.dart';

/// Khung be bo tròn viền nâu, dùng cho mọi nội dung đặt trên ảnh nền.
class KeoPanel extends StatelessWidget {
  const KeoPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(14),
    this.color = KeoColors.beige,
    this.radius = 20,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) => Container(
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius.r),
          border: Border.all(color: KeoColors.brown, width: 2),
          boxShadow: const [
            BoxShadow(
                color: Color(0x40000000), blurRadius: 8, offset: Offset(0, 4)),
          ],
        ),
        // Material trong suốt để ListTile/InkWell trong panel vẫn vẽ được hiệu ứng chạm.
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(radius.r),
          clipBehavior: Clip.antiAlias,
          child: child,
        ),
      );
}
