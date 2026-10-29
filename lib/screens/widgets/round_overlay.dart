import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/round_rules.dart';
import '../../l10n/app_localizations.dart';
import '../../ui/keo_ui.dart';

/// Lớp phủ khi tạm dừng hoặc kết thúc màn: một tấm panel giữa màn hình,
/// nội dung đổi theo [state] nên chỉ cần một widget cho cả ba trường hợp.
class RoundOverlay extends StatelessWidget {
  const RoundOverlay({
    super.key,
    required this.state,
    required this.elapsed,
    required this.best,
    required this.newBest,
    required this.finishedAll,
    required this.hasNextLevel,
    required this.onResume,
    required this.onNext,
    required this.onRestart,
    required this.onHome,
  });

  final RoundState state;
  final double elapsed;
  final double? best;
  final bool newBest;
  final bool finishedAll;
  final bool hasNextLevel;
  final VoidCallback onResume;
  final VoidCallback onNext;
  final VoidCallback onRestart;
  final VoidCallback onHome;

  bool get _paused => state == RoundState.paused;
  bool get _won => state == RoundState.won;

  String _title(AppLocalizations t) {
    if (_paused) return t.pause;
    if (finishedAll) return t.finishedAll(maxLevel);
    if (_won) return t.winTitle;
    return t.loseTitle;
  }

  ({IconData icon, Color color}) get _badge {
    if (_paused) return (icon: Icons.pause_rounded, color: KeoColors.blue);
    if (_won) {
      return (icon: Icons.emoji_events_rounded, color: KeoColors.yellow);
    }
    return (
      icon: Icons.sentiment_very_dissatisfied_rounded,
      color: const Color(0xFFE88A7A),
    );
  }

  String _bestLine(AppLocalizations t) {
    if (newBest) return t.newBest;
    return t.bestTime(best!.toStringAsFixed(1));
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final badge = _badge;
    return ColoredBox(
      color: KeoColors.scrim,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 340.w),
            child: KeoPanel(
              padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 20.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 34.r,
                    backgroundColor: badge.color,
                    child: Icon(badge.icon, size: 40.sp, color: KeoColors.ink),
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    _title(t),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w900,
                      color: KeoColors.ink,
                    ),
                  ),
                  if (!_paused) ...[
                    SizedBox(height: 6.h),
                    Text(
                      t.elapsedTime(elapsed.toStringAsFixed(1)),
                      style: TextStyle(fontSize: 17.sp, color: KeoColors.ink),
                    ),
                    if (_won && best != null)
                      Text(
                        _bestLine(t),
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w900,
                          color: KeoColors.brown,
                        ),
                      ),
                  ],
                  SizedBox(height: 18.h),
                  if (_paused) ...[
                    KeoButton(title: t.resume, onPressed: onResume),
                    SizedBox(height: 10.h),
                  ],
                  if (_won && hasNextLevel) ...[
                    KeoButton(
                      title: t.nextLevel,
                      icon: Icons.arrow_forward_rounded,
                      onPressed: onNext,
                    ),
                    SizedBox(height: 10.h),
                  ],
                  KeoButton(
                    title: t.replay,
                    color: KeoColors.blue,
                    icon: Icons.refresh,
                    onPressed: onRestart,
                  ),
                  SizedBox(height: 10.h),
                  KeoButton(
                    title: t.goHome,
                    color: Colors.white,
                    icon: Icons.home,
                    onPressed: onHome,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
