import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keo_mobile/app/keo_app.dart';
import 'package:keo_mobile/core/game_character.dart';
import 'package:keo_mobile/game/keo_game.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Nam loads idle and both running frames', (tester) async {
    final game = KeoGame(level: 1, character: GameCharacter.nam);
    await tester.pumpWidget(MaterialApp(home: GameWidget(game: game)));
    for (var i = 0; i < 20 && !game.initialized; i++) {
      await tester.runAsync(
          () async => Future<void>.delayed(const Duration(milliseconds: 50)));
      await tester.pump();
    }
    expect(game.initialized, isTrue);
    expect(game.player.sprite, same(game.playerIdleFront));
    expect(game.playerFront, hasLength(2));
    expect(game.playerBack, hasLength(2));
    expect(tester.takeException(), isNull);
  });

  testWidgets('selected character is saved and starts in an idle pose',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const ProviderScope(child: KeoApp()));
    await tester.tap(find.text('Nhân vật'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mai'));
    await tester.pump();
    expect(
      (await SharedPreferences.getInstance())
          .getString(GameCharacter.selectedKey),
      'mai',
    );
    await tester.tap(find.text('Chơi ngay'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    final finder = find.byWidgetPredicate((widget) => widget is GameWidget);
    expect(finder, findsOneWidget);
    final game = (tester.widget<GameWidget>(finder).game as KeoGame);
    for (var i = 0; i < 20 && !game.initialized; i++) {
      await tester.runAsync(
          () async => Future<void>.delayed(const Duration(milliseconds: 50)));
      await tester.pump();
    }
    expect(game.initialized, isTrue);
    expect(game.character, GameCharacter.mai);
    expect(game.player.sprite, same(game.playerIdleFront));
    expect(tester.takeException(), isNull);
  });
}
