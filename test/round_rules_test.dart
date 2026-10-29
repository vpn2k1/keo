import 'package:flutter_test/flutter_test.dart';
import 'package:keo_mobile/core/level_config.dart';
import 'package:keo_mobile/core/round_rules.dart';

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
  test('guard patrols while the player is far from its line', () {
    final far = guardStep(
      x: 100,
      dir: 1,
      distance: 10,
      playerX: 300,
      playerY: 560,
      lineY: 140,
    );
    expect(far, patrol(100, 1, 10));
  });
  test('guard closes in on the player x when the player comes near', () {
    final near = guardStep(
      x: 100,
      dir: -1,
      distance: 10,
      playerX: 300,
      playerY: 200,
      lineY: 140,
    );
    expect(near.x, 100 + 10 * guardChaseBoost);
    expect(near.dir, 1.0);
  });
  test('guard blocks the player instead of overshooting or jittering', () {
    final onTarget = guardStep(
      x: 200,
      dir: 1,
      distance: 50,
      playerX: 204,
      playerY: 150,
      lineY: 140,
    );
    expect(onTarget.x, 204);
    final blocking = guardStep(
      x: 204,
      dir: 1,
      distance: 50,
      playerX: 204.5,
      playerY: 150,
      lineY: 140,
    );
    expect(blocking.x, 204);
  });
  test('chasing guard stays inside the arena', () {
    for (final playerX in [0.0, 400.0]) {
      var g = (x: 180.0, dir: 1.0);
      for (var t = 0.0; t < 5; t += 1 / 60) {
        g = guardStep(
          x: g.x,
          dir: g.dir,
          distance: 123 / 60,
          playerX: playerX,
          playerY: 150,
          lineY: 140,
        );
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
  test('bảng màn giữ đúng bố trí cũ sau khi tách dữ liệu', () {
    expect(levelTable, hasLength(maxLevel));
    expect(LevelConfig.forLevel(1).startX, [72, 152, 232]);
    expect(LevelConfig.forLevel(3).lanes, [0, 1, 3, 4]);
    expect(LevelConfig.forLevel(6).startX, [72, 112, 152, 192, 232]);
    expect(LevelConfig.forLevel(7).startX, [300, 80, 260, 120, 220]);
    expect(LevelConfig.forLevel(10).speed, 123);
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
