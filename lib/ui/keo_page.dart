import 'package:flutter/material.dart';

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
                      onPressed: () => Navigator.maybePop(context),
                      icon: const Icon(Icons.arrow_back),
                      tooltip: 'Quay lại',
                    ),
                    Expanded(child: StrokeText(heading, size: 28)),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 380),
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
