import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../app/keo_routes.dart';
import '../l10n/app_localizations.dart';
import '../ui/keo_ui.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final steps = [
      t.tutorialStep1,
      t.tutorialStep2,
      t.tutorialStep3,
      t.tutorialStep4,
    ];
    return KeoPage(
      heading: t.howToPlay,
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          KeoPanel(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15.r,
                  backgroundColor: KeoColors.yellow,
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: KeoColors.ink,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    steps[i],
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: KeoColors.ink,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
        ],
        SizedBox(height: 6.h),
        KeoButton(
          title: t.start,
          onPressed: () => context.pushReplacement(KeoRoutes.game(1)),
        ),
      ],
    );
  }
}
