import 'package:flutter/material.dart';

import '../screens/game_screen.dart';
import '../screens/home_screen.dart';
import '../screens/level_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/tutorial_screen.dart';

/// Tên route dùng cho mọi điều hướng; không gọi MaterialPageRoute rải rác trong màn hình.
abstract final class KeoRoutes {
  static const splash = '/splash';
  static const home = '/';
  static const levels = '/levels';
  static const tutorial = '/tutorial';
  static const settings = '/settings';
  static const game = '/game';
}

final keoRoutes = <String, WidgetBuilder>{
  KeoRoutes.splash: (_) => const SplashScreen(),
  KeoRoutes.home: (_) => const HomeScreen(),
  KeoRoutes.levels: (_) => const LevelScreen(),
  KeoRoutes.tutorial: (_) => const TutorialScreen(),
  KeoRoutes.settings: (_) => const SettingsScreen(),
};

/// `game` nhận số màn qua `arguments`, nên không nằm trong bảng route tĩnh.
Route<void>? keoGameRoute(RouteSettings settings) {
  if (settings.name != KeoRoutes.game) return null;
  final level = settings.arguments;
  if (level is! int) return null;
  return MaterialPageRoute(
    settings: settings,
    builder: (_) => GameScreen(level: level),
  );
}

Future<void> pushGame(BuildContext context, int level) =>
    Navigator.pushNamed<void>(context, KeoRoutes.game, arguments: level);
