import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keo_mobile/game/keo_game.dart';

void main() {
  testWidgets('guard steps animate, pause freezes them, reset restores pose',
      (tester) async {
    final game = KeoGame(level: 1);
    await tester.pumpWidget(MaterialApp(home: GameWidget(game: game)));
    for (var i = 0; i < 20 && !game.initialized; i++) {
      await tester.runAsync(
          () async => Future<void>.delayed(const Duration(milliseconds: 50)));
      await tester.pump();
    }
    expect(game.initialized, isTrue);
    final firstFrame = game.guards.first.sprite;
    for (var i = 0; i < 5; i++) {
      game.update(0.04);
    }
    expect(game.guards.first.sprite, isNot(same(firstFrame)));
    game.pauseRound();
    final pausedFrame = game.guards.first.sprite;
    game.update(0.04);
    expect(game.guards.first.sprite, same(pausedFrame));
    game.reset();
    expect(game.guards.first.sprite, same(firstFrame));
  });
}
