import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../app/keo_routes.dart';
import '../core/round_rules.dart';
import '../l10n/app_localizations.dart';
import '../state/keo_progress.dart';
import '../ui/keo_ui.dart';

class LevelScreen extends ConsumerWidget {
  const LevelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final progress = ref.watch(progressProvider).value;
    var unlocked = 1;
    var best = const <int, double>{};
    if (progress != null) {
      unlocked = progress.unlocked;
      best = progress.bestTimes;
    }
    return KeoPage(
      heading: t.levelSelect,
      children: [
        KeoPanel(
          child: Text(
            t.unlockedCount(unlocked, maxLevel),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.w900,
              color: KeoColors.ink,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        // Ô màn co theo bề ngang thật, không dùng kích thước cố định.
        LayoutBuilder(
          builder: (context, box) {
            final width = (box.maxWidth - 24.w) / 3;
            return Wrap(
              spacing: 12.w,
              runSpacing: 12.w,
              alignment: WrapAlignment.center,
              children: [
                for (var level = 1; level <= maxLevel; level++)
                  SizedBox(
                    width: width,
                    height: width * .88,
                    child: _LevelTile(
                      level: level,
                      locked: level > unlocked,
                      best: best[level],
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _LevelTile extends StatelessWidget {
  const _LevelTile({
    required this.level,
    required this.locked,
    required this.best,
  });

  final int level;
  final bool locked;
  final double? best;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    var background = KeoColors.yellow;
    var icon = Icons.star_rounded;
    VoidCallback? tap = () => context.push(KeoRoutes.game(level));
    if (locked) {
      background = KeoColors.locked;
      icon = Icons.lock;
      tap = null;
    }
    return ElevatedButton(
      onPressed: tap,
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        disabledBackgroundColor: KeoColors.locked,
        foregroundColor: KeoColors.ink,
        disabledForegroundColor: const Color(0xFF8A8073),
        padding: EdgeInsets.zero,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
          side: const BorderSide(color: KeoColors.brown, width: 2),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 22.sp),
          Text(
            t.levelLabel(level),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800),
          ),
          if (best case final time?)
            Text(
              t.secondsShort(time.toStringAsFixed(1)),
              style: TextStyle(fontSize: 12.sp),
            ),
        ],
      ),
    );
  }
}
