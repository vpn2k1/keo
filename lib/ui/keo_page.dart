import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app/keo_routes.dart';

import 'keo_background.dart';
import 'stroke_text.dart';

/// Khung chung cho màn phụ: nền ảnh, thanh tiêu đề có nút quay lại, nội dung cuộn.
/// Nội dung bị giới hạn 380 px chiều ngang để không giãn xấu trên tablet.
class KeoPage extends StatelessWidget {
  const KeoPage({
    super.key,
    required this.heading,
    required this.children,
    this.image = 'menu',
  });

  final String heading;
  final List<Widget> children;
  final String image;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: KeoBackground(
          image: image,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 6, 8, 2),
                child: Row(
                  children: [
                    IconButton.filledTonal(
                      onPressed: () => keoPop(context),
                      icon: const Icon(Icons.arrow_back),
                      tooltip: 'Quay lại',
                    ),
                    Expanded(child: StrokeText(heading, size: 28.sp)),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 24.h),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 380.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: children,
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
