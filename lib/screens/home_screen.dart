import 'package:flutter/material.dart';

import '../app/keo_routes.dart';
import '../ui/keo_ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: KeoBackground(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const StrokeText('KEO', size: 62),
              const SizedBox(height: 8),
              const KeoPanel(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Text(
                  'VƯỢT PHÒNG TUYẾN',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: KeoColors.ink,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              // Spacer thay cho Alignment cố định: nút luôn nằm trên bãi cỏ dù màn hình cao hay thấp.
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 340),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        KeoButton(
                          title: 'Chơi ngay',
                          onPressed: () => pushGame(context, 1),
                        ),
                        const SizedBox(height: 12),
                        KeoButton(
                          title: 'Chọn màn',
                          color: KeoColors.blue,
                          icon: Icons.map,
                          onPressed: () =>
                              Navigator.pushNamed(context, KeoRoutes.levels),
                        ),
                        const SizedBox(height: 12),
                        KeoButton(
                          title: 'Cách chơi',
                          color: KeoColors.beige,
                          icon: Icons.help,
                          onPressed: () =>
                              Navigator.pushNamed(context, KeoRoutes.tutorial),
                        ),
                        const SizedBox(height: 12),
                        KeoButton(
                          title: 'Cài đặt',
                          color: KeoColors.beige,
                          icon: Icons.settings,
                          onPressed: () =>
                              Navigator.pushNamed(context, KeoRoutes.settings),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 26),
            ],
          ),
        ),
      );
}
