import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keo_mobile/game/keo_game.dart';
import 'package:keo_mobile/screens/widgets/round_overlay.dart';

Widget _overlay(RoundState state,
        {bool hasNextLevel = true, bool newBest = false, double? best}) =>
    MaterialApp(
      home: Scaffold(
        body: RoundOverlay(
          state: state,
          elapsed: 9.87,
          best: best,
          newBest: newBest,
          finishedAll: false,
          hasNextLevel: hasNextLevel,
          onResume: () {},
          onNext: () {},
          onRestart: () {},
          onHome: () {},
        ),
      ),
    );

void main() {
  testWidgets('pause shows resume and hides the round result', (tester) async {
    await tester.pumpWidget(_overlay(RoundState.paused));
    expect(find.text('Tạm dừng'), findsOneWidget);
    expect(find.text('Tiếp tục'), findsOneWidget);
    expect(find.textContaining('Thời gian'), findsNothing);
    expect(find.text('Màn tiếp'), findsNothing);
  });

  testWidgets('win shows time, new best and the next level button',
      (tester) async {
    await tester
        .pumpWidget(_overlay(RoundState.won, newBest: true, best: 9.87));
    expect(find.text('Chiến thắng!'), findsOneWidget);
    expect(find.text('Thời gian: 9.9s'), findsOneWidget);
    expect(find.text('Kỷ lục mới!'), findsOneWidget);
    expect(find.text('Màn tiếp'), findsOneWidget);
  });

  testWidgets('loss on the last level offers replay only', (tester) async {
    await tester
        .pumpWidget(_overlay(RoundState.lost, hasNextLevel: false, best: 5));
    expect(find.text('Bị bắt rồi!'), findsOneWidget);
    expect(find.text('Màn tiếp'), findsNothing);
    expect(find.text('Chơi lại'), findsOneWidget);
    expect(find.text('Về trang chủ'), findsOneWidget);
  });
}
