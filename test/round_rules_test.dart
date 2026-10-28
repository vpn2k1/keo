import 'package:flutter_test/flutter_test.dart';
import 'package:keo_mobile/game/level_config.dart';
import 'package:keo_mobile/game/round_rules.dart';

void main() {
  test('only return to start after reaching finish', () {
    expect(hasWon(reachedFinish: false, playerY: 560), false);
    expect(hasWon(reachedFinish: true, playerY: 560), true);
    expect(hasWon(reachedFinish: true, playerY: 300), false);
  });
  test('guard contact uses the radius sum', () {
    expect(isCaught(0, 0, 26.9, 0, 27), true);
    expect(isCaught(0, 0, 27, 0, 27), false);
    expect(isCaught(0, 0, 100, 0, 27), false);
  });
  test('patrol bounces off both edges and keeps moving otherwise', () {
    expect(patrol(100, 1, 10), (x: 110.0, dir: 1.0));
    expect(patrol(320, 1, 10), (x: arenaMaxX, dir: -1.0));
    expect(patrol(40, -1, 10), (x: arenaMinX, dir: 1.0));
  });
  test('guard stays in the arena over a long patrol at any frame rate', () {
    for (final dt in [1 / 30, 1 / 60, 1 / 120]) {
      var g = (x: 72.0, dir: 1.0);
      for (var t = 0.0; t < 60; t += dt) {
        g = patrol(g.x, g.dir, 132 * dt);
        expect(g.x, inInclusiveRange(arenaMinX, arenaMaxX));
      }
    }
  });
  test('lines crossed counts lines below the player', () {
    const lines = [145.0, 230.0, 315.0, 400.0, 485.0];
    expect(linesCrossed(lines, 563), 0);
    expect(linesCrossed(lines, 350), 2);
    expect(linesCrossed(lines, 70), 5);
  });
  test('winning unlocks the next level once, capped at the last level', () {
    expect(nextUnlocked(1, 1), 2);
    expect(nextUnlocked(5, 2), 5);
    expect(nextUnlocked(maxLevel, maxLevel), maxLevel);
  });
  test('best time only improves', () {
    expect(isNewBest(null, 12), true);
    expect(isNewBest(10, 9.5), true);
    expect(isNewBest(10, 10), false);
  });
  test('every level has a valid config and difficulty grows', () {
    final configs = [
      for (var l = 1; l <= maxLevel; l++) LevelConfig.forLevel(l)
    ];
    expect(configs.map((c) => c.lanes.length), [3, 4, 4, 5, 5, 5, 5, 5, 5, 5]);
    for (var i = 1; i < configs.length; i++) {
      expect(configs[i].speed, greaterThan(configs[i - 1].speed));
    }
    expect(() => LevelConfig.forLevel(0), throwsArgumentError);
    expect(() => LevelConfig.forLevel(maxLevel + 1), throwsArgumentError);
    expect(() => LevelConfig(lanes: [0, 0], startX: [72, 72], speed: 80),
        throwsArgumentError);
    expect(() => LevelConfig(lanes: [0], startX: [10], speed: 80),
        throwsArgumentError);
  });
}
