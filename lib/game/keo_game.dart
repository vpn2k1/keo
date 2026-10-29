import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../core/game_character.dart';
import '../core/level_config.dart';
import '../core/round_rules.dart';

class KeoGame extends FlameGame {
  KeoGame({required this.level, this.character = GameCharacter.keo})
      : config = LevelConfig.forLevel(level),
        super(
          camera: CameraComponent.withFixedResolution(width: 360, height: 640),
        );
  final int level;
  final GameCharacter character;
  final LevelConfig config;
  final status = ValueNotifier<RoundState>(RoundState.running);
  final reachedEnd = ValueNotifier<bool>(false);
  final elapsed = ValueNotifier<double>(0);
  final crossed = ValueNotifier<int>(0);
  final List<SpriteComponent> guards = [];
  final List<double> directions = [];
  final List<double> lineY = [140, 212, 298, 378, 456];
  late final List<Sprite> playerFront;
  late final List<Sprite> playerBack;
  late final Sprite playerIdleFront;
  late final Sprite playerIdleBack;
  late final List<Sprite> guardFrames;
  late final SpriteComponent player;
  late final JoystickComponent joystick;
  bool initialized = false;
  bool facingUp = false;
  double animationTime = 0;
  final double speed = 170;
  // Transparent so the Flutter field colour behind GameWidget shows instead of Flame's default black.
  @override
  Color backgroundColor() => const Color(0x00000000);
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // World coordinates are laid out from the top-left (0..360, 0..640); Flame centres (0,0) by default.
    camera.viewfinder.anchor = Anchor.topLeft;
    await world.add(
      SpriteComponent(
        sprite: Sprite(await images.load('field.png')),
        size: Vector2(360, 640),
      ),
    );
    playerIdleFront = Sprite(await images.load(character.idleImage()));
    playerIdleBack = Sprite(await images.load(character.idleImage(back: true)));
    playerFront = [
      for (var i = 0; i < 2; i++)
        Sprite(await images.load(character.runImage(i))),
    ];
    playerBack = [
      for (var i = 0; i < 2; i++)
        Sprite(await images.load(character.runImage(i, back: true))),
    ];
    guardFrames = [
      Sprite(await images.load('guard.png')),
      Sprite(await images.load('guard_step.png')),
    ];
    for (var i = 0; i < config.lanes.length; i++) {
      final guard = SpriteComponent(
        sprite: guardFrames[0],
        size: Vector2(44, 50),
        anchor: Anchor.center,
        position: Vector2(config.startX[i], lineY[config.lanes[i]]),
      );
      guards.add(guard);
      directions.add(_laneDirection(config.lanes[i]));
      await world.add(guard);
    }
    await world.add(
      RectangleComponent(
        position: Vector2(20, 70),
        size: Vector2(320, 5),
        paint: Paint()..color = const Color(0xFFE64530),
      ),
    );
    player = SpriteComponent(
      sprite: playerIdleFront,
      size: Vector2(44, 54),
      anchor: Anchor.center,
      position: Vector2(180, 563),
    );
    await world.add(player);
    joystick = JoystickComponent(
      knob: CircleComponent(
        radius: 22,
        paint: Paint()..color = const Color(0xFFCDE6FF),
      ),
      background: CircleComponent(
        radius: 58,
        paint: Paint()..color = const Color(0x994A6A88),
      ),
      margin: const EdgeInsets.only(left: 25, bottom: 20),
    );
    await camera.viewport.add(joystick);
    initialized = true;
    reset();
  }

  void reset() {
    if (!initialized) return;
    player.position.setValues(180, 563);
    player.sprite = playerIdleFront;
    player.scale.setValues(1, 1);
    player.angle = 0;
    facingUp = false;
    animationTime = 0;
    for (var i = 0; i < guards.length; i++) {
      guards[i].position.setValues(config.startX[i], lineY[config.lanes[i]]);
      directions[i] = _laneDirection(config.lanes[i]);
      guards[i].sprite = guardFrames[0];
      guards[i].scale.setValues(_flipX(-directions[i]), 1);
      guards[i].angle = 0;
    }
    elapsed.value = 0;
    crossed.value = 0;
    reachedEnd.value = false;
    status.value = RoundState.running;
  }

  /// Người canh vạch chẵn chạy sang phải trước, vạch lẻ sang trái.
  double _laneDirection(int lane) {
    if (lane.isEven) return 1;
    return -1;
  }

  /// Sprite vẽ sẵn hướng sang phải, nên đi sang trái thì lật ngang.
  double _flipX(double dx) {
    if (dx < 0) return -1;
    return 1;
  }

  Sprite _playerSprite(bool moving) {
    if (!moving) {
      if (facingUp) return playerIdleBack;
      return playerIdleFront;
    }
    final frame = (animationTime * 9).floor() % 2;
    if (facingUp) return playerBack[frame];
    return playerFront[frame];
  }

  double _playerBob(bool moving) {
    if (moving) return 1 + 0.04 * math.sin(animationTime * 18);
    return 1 + 0.015 * math.sin(animationTime * 3);
  }

  double _playerTilt(bool moving, double dx) {
    if (moving) return dx * 0.06;
    return 0;
  }

  void pauseRound() {
    if (status.value == RoundState.running) status.value = RoundState.paused;
  }

  void resumeRound() {
    if (status.value == RoundState.paused) status.value = RoundState.running;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!initialized || status.value != RoundState.running) return;
    dt = math.min(dt, 0.04);
    elapsed.value += dt;
    animationTime += dt;
    final movement = joystick.relativeDelta;
    player.position.add(movement * speed * dt);
    player.position.x = player.position.x.clamp(33.0, 327.0).toDouble();
    player.position.y = player.position.y.clamp(70.0, 566.0).toDouble();
    final moving = movement.length2 > 0.0025;
    if (moving && movement.y.abs() > 0.2) facingUp = movement.y < 0;
    player.sprite = _playerSprite(moving);
    if (moving && movement.x.abs() > 0.12) {
      player.scale.x = _flipX(movement.x);
    }
    player.scale.y = _playerBob(moving);
    player.angle = _playerTilt(moving, movement.x);
    for (var i = 0; i < guards.length; i++) {
      final g = guards[i];
      final next = guardStep(
        x: g.position.x,
        dir: directions[i],
        distance: (config.speed + config.lanes[i] * 3) * dt,
        playerX: player.position.x,
        playerY: player.position.y,
        lineY: g.position.y,
      );
      g.position.x = next.x;
      directions[i] = next.dir;
      g.sprite = guardFrames[(animationTime * 6 + i * 0.35).floor() % 2];
      g.scale.setValues(
          _flipX(-next.dir), 1 + 0.03 * math.sin(animationTime * 12 + i));
      if (isCaught(
        player.position.x,
        player.position.y,
        g.position.x,
        g.position.y,
        27,
      )) {
        status.value = RoundState.lost;
        return;
      }
    }
    if (player.position.y < goalY) reachedEnd.value = true;
    if (!reachedEnd.value) {
      crossed.value = linesCrossed(lineY, player.position.y);
    }
    if (hasWon(reachedFinish: reachedEnd.value, playerY: player.position.y)) {
      status.value = RoundState.won;
    }
  }
}
