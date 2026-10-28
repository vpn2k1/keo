import 'package:flutter/material.dart';

import '../app/keo_routes.dart';
import '../ui/keo_ui.dart';

const _steps = [
  'Kéo joystick ở góc trái để chạy theo mọi hướng.',
  'Người canh chỉ chạy trái/phải trên vạch ngang của mình.',
  'Chạm phải người canh là thua ngay, phải chơi lại màn.',
  'Vượt qua vạch đích đỏ rồi quay về xuất phát mới thắng.',
];

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) => KeoPage(
        heading: 'Cách chơi',
        children: [
          for (var i = 0; i < _steps.length; i++) ...[
            KeoPanel(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: KeoColors.yellow,
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: KeoColors.ink,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _steps[i],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: KeoColors.ink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 6),
          KeoButton(
            title: 'Bắt đầu',
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                KeoRoutes.game,
                arguments: 1,
              );
            },
          ),
        ],
      );
}
