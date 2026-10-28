import 'dart:math' as math;

const int maxLevel = 10;
const double arenaMinX = 36, arenaMaxX = 324;
const double goalY = 78, startY = 555;

bool hasWon({required bool reachedFinish, required double playerY}) =>
    reachedFinish && playerY > startY;
bool isCaught(double px, double py, double gx, double gy, double radiusSum) =>
    math.sqrt(math.pow(px - gx, 2) + math.pow(py - gy, 2)) < radiusSum;

/// Moves a guard along its line and bounces it off the arena edges.
({double x, double dir}) patrol(double x, double dir, double distance) {
  x += dir * distance;
  if (x < arenaMinX) return (x: arenaMinX, dir: 1);
  if (x > arenaMaxX) return (x: arenaMaxX, dir: -1);
  return (x: x, dir: dir);
}

/// Number of lines the player is above (lines are crossed from bottom to top).
int linesCrossed(List<double> lineY, double playerY) =>
    lineY.where((y) => playerY < y).length;

int nextUnlocked(int current, int wonLevel) =>
    wonLevel >= current ? (wonLevel + 1).clamp(1, maxLevel) : current;
bool isNewBest(double? best, double time) => best == null || time < best;
String bestTimeKey(int level) => 'best_$level';
