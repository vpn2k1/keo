import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keo_mobile/app/keo_app.dart';
import 'package:keo_mobile/core/round_rules.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('level select reflects saved progress and best time', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({
      'unlocked': 3,
      bestTimeKey(1): 12.34,
    });
    await tester.pumpWidget(const ProviderScope(child: KeoApp()));
    await tester.pumpAndSettle();
    expect(find.text('Chơi ngay'), findsOneWidget);
    await tester.tap(find.text('Chọn màn'));
    await tester.pumpAndSettle();
    expect(find.text('Đã mở khóa: 3/$maxLevel'), findsOneWidget);
    expect(find.text('12.3s'), findsOneWidget);
    expect(find.byIcon(Icons.lock), findsNWidgets(maxLevel - 3));
  });

  testWidgets('vibration setting is saved without pressing a button', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const ProviderScope(child: KeoApp()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cài đặt'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rung'));
    await tester.pumpAndSettle();
    expect((await SharedPreferences.getInstance()).getBool('vibration'), false);
  });
}
