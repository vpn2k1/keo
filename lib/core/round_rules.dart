import 'dart:math' as math;

const int maxLevel = 10;
const double arenaMinX = 36, arenaMaxX = 324;
const double goalY = 78, startY = 555;

/// Trạng thái một ván: đang chơi, tạm dừng, thắng, thua.
enum RoundState { running, paused, won, lost }

bool hasWon({required bool reachedFinish, required double playerY}) =>
    reachedFinish && playerY > startY;

bool isCaught(double px, double py, double gx, double gy, double radiusSum) =>
    math.sqrt(math.pow(px - gx, 2) + math.pow(py - gy, 2)) < radiusSum;

/// Đi dọc vạch và dội lại ở hai mép sân.
({double x, double dir}) patrol(double x, double dir, double distance) {
  x += dir * distance;
  if (x < arenaMinX) return (x: arenaMinX, dir: 1);
  if (x > arenaMaxX) return (x: arenaMaxX, dir: -1);
  return (x: x, dir: dir);
}

/// Khoảng cách dọc mà người canh bắt đầu bám theo người chơi (world units).
/// Vạch cách nhau ~72–86 nên thường chỉ vạch trên và vạch dưới người chơi phản ứng.
const double guardReach = 120;

/// Bám nhanh hơn tuần tra, nhưng vẫn chậm hơn tốc độ người chơi (170) để còn né được.
const double guardChaseBoost = 1.2;

/// Người canh chặn đường: tới gần thì chạy canh theo trục X của người chơi,
/// ra xa thì tuần tra như cũ. [distance] là quãng đi được trong khung hình này.
({double x, double dir}) guardStep({
  required double x,
  required double dir,
  required double distance,
  required double playerX,
  required double playerY,
  required double lineY,
}) {
  if ((playerY - lineY).abs() > guardReach) return patrol(x, dir, distance);
  final toward = playerX - x;
  // Đã chặn đúng trước mặt thì đứng im, không rung qua lại quanh người chơi.
  if (toward.abs() < 1) return (x: x, dir: dir);
  final step = math.min(toward.abs(), distance * guardChaseBoost) * toward.sign;
  return (x: (x + step).clamp(arenaMinX, arenaMaxX), dir: toward.sign);
}

/// Số vạch người chơi đã vượt qua (tính từ dưới lên).
int linesCrossed(List<double> lineY, double playerY) =>
    lineY.where((y) => playerY < y).length;

int nextUnlocked(int current, int wonLevel) {
  if (wonLevel < current) return current;
  return (wonLevel + 1).clamp(1, maxLevel);
}

bool isNewBest(double? best, double time) => best == null || time < best;

String bestTimeKey(int level) => 'best_$level';
