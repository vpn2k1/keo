import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/keo_routes.dart';
import '../game/keo_game.dart';
import '../game/round_rules.dart';
import '../ui/keo_ui.dart';
import 'widgets/round_overlay.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.level});

  final int level;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with WidgetsBindingObserver {
  late final KeoGame game;
  bool saved = false;
  bool vibration = true;
  bool newBest = false;
  double? best;

  @override
  void initState() {
    super.initState();
    game = KeoGame(level: widget.level);
    game.status.addListener(_onStatus);
    WidgetsBinding.instance.addObserver(this);
    SharedPreferences.getInstance().then((p) {
      if (!mounted) return;
      setState(() {
        vibration = p.getBool('vibration') ?? true;
        best = p.getDouble(bestTimeKey(widget.level));
      });
    });
  }

  // Cuộc gọi, thông báo hay chuyển app không được để người canh bắt người chơi khi màn hình đã tắt.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) game.pauseRound();
  }

  void _onStatus() {
    final s = game.status.value;
    if (s == RoundState.won) {
      if (vibration) HapticFeedback.mediumImpact();
      if (!saved) {
        saved = true;
        _saveProgress(game.elapsed.value);
      }
      return;
    }
    if (s == RoundState.lost && vibration) HapticFeedback.heavyImpact();
  }

  Future<void> _saveProgress(double time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
      'unlocked',
      nextUnlocked(prefs.getInt('unlocked') ?? 1, widget.level),
    );
    final previous = prefs.getDouble(bestTimeKey(widget.level));
    final isBest = isNewBest(previous, time);
    if (isBest) await prefs.setDouble(bestTimeKey(widget.level), time);
    if (!mounted) return;
    setState(() {
      newBest = isBest;
      best = previous;
      if (isBest) best = time;
    });
  }

  void _restart() {
    saved = false;
    newBest = false;
    game.reset();
  }

  void _nextLevel() => Navigator.pushReplacementNamed(
        context,
        KeoRoutes.game,
        arguments: widget.level + 1,
      );

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    game.status.removeListener(_onStatus);
    game.status.dispose();
    game.reachedEnd.dispose();
    game.elapsed.dispose();
    game.crossed.dispose();
    super.dispose();
  }

  // Back khi đang chơi thì tạm dừng; back khi đang ở lớp phủ thì thoát màn.
  void _onPop(bool didPop, Object? result) {
    if (didPop) return;
    if (game.status.value == RoundState.running) {
      game.pauseRound();
      return;
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: false,
        onPopInvokedWithResult: _onPop,
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              const ColoredBox(color: KeoColors.grass),
              GameWidget(game: game),
              SafeArea(
                child: Column(
                  children: [
                    _Hud(level: widget.level, game: game),
                    const SizedBox(height: 8),
                    _GoalBanner(game: game),
                  ],
                ),
              ),
              ValueListenableBuilder<RoundState>(
                valueListenable: game.status,
                builder: (context, state, _) {
                  if (state == RoundState.running) {
                    return const SizedBox.shrink();
                  }
                  return RoundOverlay(
                    state: state,
                    elapsed: game.elapsed.value,
                    best: best,
                    newBest: newBest,
                    finishedAll:
                        state == RoundState.won && widget.level == maxLevel,
                    hasNextLevel: widget.level < maxLevel,
                    onResume: game.resumeRound,
                    onNext: _nextLevel,
                    onRestart: _restart,
                    onHome: () => Navigator.of(context)
                        .popUntil((route) => route.isFirst),
                  );
                },
              ),
            ],
          ),
        ),
      );
}

class _Hud extends StatelessWidget {
  const _Hud({required this.level, required this.game});

  final int level;
  final KeoGame game;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            KeoPanel(
              radius: 14,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              child: Text(
                'Màn $level',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: KeoColors.ink,
                ),
              ),
            ),
            ValueListenableBuilder<double>(
              valueListenable: game.elapsed,
              builder: (context, value, _) => KeoPanel(
                radius: 14,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                child: Text(
                  '${value.toStringAsFixed(1)}s',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: KeoColors.ink,
                  ),
                ),
              ),
            ),
            IconButton.filled(
              onPressed: game.pauseRound,
              icon: const Icon(Icons.pause),
              tooltip: 'Tạm dừng',
              style: IconButton.styleFrom(
                backgroundColor: KeoColors.yellow,
                foregroundColor: KeoColors.ink,
                side: const BorderSide(color: KeoColors.brown, width: 2),
              ),
            ),
          ],
        ),
      );
}

class _GoalBanner extends StatelessWidget {
  const _GoalBanner({required this.game});

  final KeoGame game;

  String _text() {
    if (game.reachedEnd.value) return 'QUAY VỀ XUẤT PHÁT!';
    return 'ĐI TỚI ĐÍCH · ${game.crossed.value}/${game.lineY.length} vạch';
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: Listenable.merge([game.reachedEnd, game.crossed]),
        builder: (context, _) => KeoPanel(
          radius: 30,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Text(
            _text(),
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: KeoColors.ink,
            ),
          ),
        ),
      );
}
