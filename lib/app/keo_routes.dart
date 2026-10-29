import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../screens/character_screen.dart';
import '../screens/game_screen.dart';
import '../screens/home_screen.dart';
import '../screens/level_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/tutorial_screen.dart';

/// Đường dẫn dùng cho mọi điều hướng; màn hình không tự tạo route.
abstract final class KeoRoutes {
  static const home = '/';
  static const levels = '/levels';
  static const tutorial = '/tutorial';
  static const settings = '/settings';
  static const character = '/character';
  static String game(int level) => '/game/$level';
}

GoRouter createKeoRouter({String initialLocation = KeoRoutes.home}) => GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(path: KeoRoutes.home, builder: (_, __) => const HomeScreen()),
        GoRoute(
            path: KeoRoutes.levels, builder: (_, __) => const LevelScreen()),
        GoRoute(
            path: KeoRoutes.tutorial,
            builder: (_, __) => const TutorialScreen()),
        GoRoute(
            path: KeoRoutes.settings,
            builder: (_, __) => const SettingsScreen()),
        GoRoute(
            path: KeoRoutes.character,
            builder: (_, __) => const CharacterScreen()),
        GoRoute(
          path: '/game/:level',
          builder: (_, state) => GameScreen(
              level: int.tryParse(state.pathParameters['level']!) ?? 1),
        ),
      ],
    );

/// Nút quay lại: về màn trước nếu có, không thì về trang chủ.
void keoPop(BuildContext context) {
  if (context.canPop()) {
    context.pop();
    return;
  }
  context.go(KeoRoutes.home);
}
