import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../app/keo_routes.dart';
import '../l10n/app_localizations.dart';
import '../ui/keo_ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: KeoBackground(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            StrokeText(t.gameName, size: 62.sp),
            SizedBox(height: 8.h),
            KeoPanel(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              child: Text(
                t.gameSubtitle,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w900,
                  color: KeoColors.ink,
                  letterSpacing: 1.1,
                ),
              ),
            ),
            // Spacer thay cho toạ độ cố định: nút luôn nằm trên bãi cỏ dù màn hình cao hay thấp.
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 340.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      KeoButton(
                        title: t.playNow,
                        onPressed: () => context.push(KeoRoutes.game(1)),
                      ),
                      SizedBox(height: 12.h),
                      KeoButton(
                        title: t.levelSelect,
                        color: KeoColors.blue,
                        icon: Icons.map,
                        onPressed: () => context.push(KeoRoutes.levels),
                      ),
                      SizedBox(height: 12.h),
                      KeoButton(
                        title: t.character,
                        color: KeoColors.blue,
                        icon: Icons.person,
                        onPressed: () => context.push(KeoRoutes.character),
                      ),
                      SizedBox(height: 12.h),
                      KeoButton(
                        title: t.howToPlay,
                        color: KeoColors.beige,
                        icon: Icons.help,
                        onPressed: () => context.push(KeoRoutes.tutorial),
                      ),
                      SizedBox(height: 12.h),
                      KeoButton(
                        title: t.settings,
                        color: KeoColors.beige,
                        icon: Icons.settings,
                        onPressed: () => context.push(KeoRoutes.settings),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 26.h),
          ],
        ),
      ),
    );
  }
}
