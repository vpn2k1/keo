import 'package:flutter/material.dart';

import '../../game/keo_game.dart';
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

  String get _title {
    if (_paused) return 'Tạm dừng';
    if (finishedAll) return 'Phá đảo 10 màn!';
    if (_won) return 'Chiến thắng!';
    return 'Bị bắt rồi!';
  }

  ({IconData icon, Color color}) get _badge {
    if (_paused) return (icon: Icons.pause_rounded, color: KeoColors.blue);
    if (_won) {
      return (icon: Icons.emoji_events_rounded, color: KeoColors.yellow);
    }
    return (
      icon: Icons.sentiment_very_dissatisfied_rounded,
      color: Color(0xFFE88A7A)
    );
  }

  String get _bestLine {
    if (newBest) return 'Kỷ lục mới!';
    return 'Kỷ lục: ${best!.toStringAsFixed(1)}s';
  }

  @override
  Widget build(BuildContext context) {
    final badge = _badge;
    return ColoredBox(
      color: KeoColors.scrim,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 340),
            child: KeoPanel(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor: badge.color,
                    child: Icon(badge.icon, size: 40, color: KeoColors.ink),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    _title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: KeoColors.ink,
                    ),
                  ),
                  if (!_paused) ...[
                    const SizedBox(height: 6),
                    Text(
                      'Thời gian: ${elapsed.toStringAsFixed(1)}s',
                      style:
                          const TextStyle(fontSize: 17, color: KeoColors.ink),
                    ),
                    if (_won && best != null)
                      Text(
                        _bestLine,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          color: KeoColors.brown,
                        ),
                      ),
                  ],
                  const SizedBox(height: 18),
                  if (_paused) ...[
                    KeoButton(title: 'Tiếp tục', onPressed: onResume),
                    const SizedBox(height: 10),
                  ],
                  if (_won && hasNextLevel) ...[
                    KeoButton(
                      title: 'Màn tiếp',
                      icon: Icons.arrow_forward_rounded,
                      onPressed: onNext,
                    ),
                    const SizedBox(height: 10),
                  ],
                  KeoButton(
                    title: 'Chơi lại',
                    color: KeoColors.blue,
                    icon: Icons.refresh,
                    onPressed: onRestart,
                  ),
                  const SizedBox(height: 10),
                  KeoButton(
                    title: 'Về trang chủ',
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
