import 'round_rules.dart';

/// Guard layout for one level. Lanes index into KeoGame.lineY (0 = top line).
class LevelConfig {
  LevelConfig(
      {required this.lanes, required this.startX, required this.speed}) {
    if (lanes.isEmpty || lanes.length != startX.length) {
      throw ArgumentError('lanes and startX must match and not be empty');
    }
    if (lanes.toSet().length != lanes.length ||
        lanes.any((l) => l < 0 || l > 4)) {
      throw ArgumentError('lanes must be unique and in 0..4');
    }
    if (startX.any((x) => x < arenaMinX || x > arenaMaxX)) {
      throw ArgumentError('startX must be inside the arena');
    }
    if (speed <= 0) throw ArgumentError('speed must be positive');
  }
  final List<int> lanes;
  final List<double> startX;
  final double speed;

  /// Difficulty curve from docs/GAME_DESIGN.md: 3 guards on level 1, 4 on 2–3, 5 from 4; harder start points from 7.
  factory LevelConfig.forLevel(int level) {
    if (level < 1 || level > maxLevel) {
      throw ArgumentError.value(level, 'level', 'must be 1..$maxLevel');
    }
    final lanes = level == 1
        ? [0, 2, 4]
        : level <= 3
            ? [0, 1, 3, 4]
            : [0, 1, 2, 3, 4];
    final startX = [
      for (final l in lanes)
        level >= 7 ? (l.isEven ? 300.0 - l * 20 : 60.0 + l * 20) : 72.0 + l * 40
    ];
    return LevelConfig(lanes: lanes, startX: startX, speed: 73.0 + level * 5);
  }
}
