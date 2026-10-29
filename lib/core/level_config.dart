import 'round_rules.dart';

/// Bố trí người canh của một màn. [lanes] là chỉ số vạch (0 = vạch trên cùng),
/// [startX] là điểm xuất phát tương ứng, [speed] là tốc độ tuần tra.
class LevelConfig {
  LevelConfig({
    required this.lanes,
    required this.startX,
    required this.speed,
  }) {
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

  /// Đường cong độ khó (docs/GAME_DESIGN.md): 3 người canh ở màn 1, 4 ở màn 2–3,
  /// 5 từ màn 4; từ màn 7 điểm xuất phát so le hai mép sân. Sửa độ khó ở bảng này.
  factory LevelConfig.forLevel(int level) {
    if (level < 1 || level > maxLevel) {
      throw ArgumentError.value(level, 'level', 'must be 1..$maxLevel');
    }
    final data = levelTable[level - 1];
    return LevelConfig(
      lanes: data.lanes,
      startX: data.startX,
      speed: data.speed,
    );
  }
}

/// Dữ liệu thô của một màn, khai báo thẳng để chỉnh từng màn một.
class LevelData {
  const LevelData({
    required this.lanes,
    required this.startX,
    required this.speed,
  });

  final List<int> lanes;
  final List<double> startX;
  final double speed;
}

const levelTable = <LevelData>[
  LevelData(lanes: [0, 2, 4], startX: [72, 152, 232], speed: 78),
  LevelData(lanes: [0, 1, 3, 4], startX: [72, 112, 192, 232], speed: 83),
  LevelData(lanes: [0, 1, 3, 4], startX: [72, 112, 192, 232], speed: 88),
  LevelData(
      lanes: [0, 1, 2, 3, 4], startX: [72, 112, 152, 192, 232], speed: 93),
  LevelData(
      lanes: [0, 1, 2, 3, 4], startX: [72, 112, 152, 192, 232], speed: 98),
  LevelData(
    lanes: [0, 1, 2, 3, 4],
    startX: [72, 112, 152, 192, 232],
    speed: 103,
  ),
  LevelData(
      lanes: [0, 1, 2, 3, 4], startX: [300, 80, 260, 120, 220], speed: 108),
  LevelData(
      lanes: [0, 1, 2, 3, 4], startX: [300, 80, 260, 120, 220], speed: 113),
  LevelData(
      lanes: [0, 1, 2, 3, 4], startX: [300, 80, 260, 120, 220], speed: 118),
  LevelData(
      lanes: [0, 1, 2, 3, 4], startX: [300, 80, 260, 120, 220], speed: 123),
];
