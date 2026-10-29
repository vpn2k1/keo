import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/round_rules.dart';

/// Tiến trình đã lưu: màn đã mở khóa và kỷ lục thời gian từng màn.
class KeoProgress {
  const KeoProgress({required this.unlocked, required this.bestTimes});

  final int unlocked;
  final Map<int, double> bestTimes;
}

class ProgressNotifier extends AsyncNotifier<KeoProgress> {
  @override
  Future<KeoProgress> build() async {
    final p = await SharedPreferences.getInstance();
    return KeoProgress(
      unlocked: p.getInt('unlocked') ?? 1,
      bestTimes: {
        for (var l = 1; l <= maxLevel; l++)
          if (p.getDouble(bestTimeKey(l)) case final t?) l: t,
      },
    );
  }

  /// Ghi kết quả thắng; trả về true nếu đó là kỷ lục mới của màn.
  Future<bool> recordWin(int level, double time) async {
    final p = await SharedPreferences.getInstance();
    final unlocked = nextUnlocked(p.getInt('unlocked') ?? 1, level);
    await p.setInt('unlocked', unlocked);
    final previous = p.getDouble(bestTimeKey(level));
    final isBest = isNewBest(previous, time);
    if (isBest) await p.setDouble(bestTimeKey(level), time);
    final times = Map<int, double>.from(state.value?.bestTimes ?? {});
    if (isBest) times[level] = time;
    state = AsyncData(KeoProgress(unlocked: unlocked, bestTimes: times));
    return isBest;
  }
}

final progressProvider = AsyncNotifierProvider<ProgressNotifier, KeoProgress>(
  ProgressNotifier.new,
);
