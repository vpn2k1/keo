import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../app/keo_audio.dart';
import '../app/keo_routes.dart';
import '../core/game_character.dart';
import '../game/keo_game.dart';
import '../core/round_rules.dart';
import '../l10n/app_localizations.dart';
import '../state/keo_character.dart';
import '../state/keo_progress.dart';
import '../state/keo_settings.dart';
import '../ui/keo_ui.dart';
import 'widgets/round_overlay.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key, required this.level});

  final int level;

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen>
    with WidgetsBindingObserver {
  KeoGame? _game;
  late final KeoAudio audio;
  bool saved = false;
  bool newBest = false;

  @override
  void initState() {
    super.initState();
    audio = ref.read(audioProvider);
    WidgetsBinding.instance.addObserver(this);
  }

  /// Chỉ dựng game khi đã biết nhân vật đã chọn, để không lỡ lấy nhân vật mặc định.
  KeoGame _ensureGame(GameCharacter character) {
    final existing = _game;
    if (existing != null) return existing;
    final created = KeoGame(level: widget.level, character: character);
    created.status.addListener(_onStatus);
    audio.startMusic();
    _game = created;
    return created;
  }

  bool get _vibration => ref.read(settingsProvider).value?.vibration ?? true;

  // Cuộc gọi, thông báo hay chuyển app không được để người canh bắt người chơi khi màn hình đã tắt.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) _game?.pauseRound();
  }

  void _onStatus() {
    final game = _game;
    if (game == null) return;
    final s = game.status.value;
    if (s == RoundState.won) {
      if (_vibration) HapticFeedback.mediumImpact();
      audio.win();
      if (!saved) {
        saved = true;
        _saveProgress(game.elapsed.value);
      }
      return;
    }
    if (s == RoundState.lost) {
      if (_vibration) HapticFeedback.heavyImpact();
      audio.lose();
    }
  }

  Future<void> _saveProgress(double time) async {
    final isBest =
        await ref.read(progressProvider.notifier).recordWin(widget.level, time);
    if (!mounted) return;
    setState(() => newBest = isBest);
  }

  void _restart() {
    saved = false;
    newBest = false;
    _game?.reset();
  }

  @override
  void dispose() {
    audio.stopMusic();
    WidgetsBinding.instance.removeObserver(this);
    final game = _game;
    if (game != null) {
      game.status.removeListener(_onStatus);
      game.status.dispose();
      game.reachedEnd.dispose();
      game.elapsed.dispose();
      game.crossed.dispose();
    }
    super.dispose();
  }

  // Back khi đang chơi thì tạm dừng; back khi đang ở lớp phủ thì thoát màn.
  void _onPop(bool didPop, Object? result) {
    if (didPop) return;
    if (_game?.status.value == RoundState.running) {
      _game?.pauseRound();
      return;
    }
    keoPop(context);
  }

  @override
  Widget build(BuildContext context) {
    final character = ref.watch(characterProvider).value;
    if (character == null) {
      return const Scaffold(
        backgroundColor: KeoColors.grass,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final game = _ensureGame(character);
    final best = ref.watch(progressProvider).value?.bestTimes[widget.level];
    return PopScope(
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
                  SizedBox(height: 8.h),
                  _GoalBanner(game: game),
                ],
              ),
            ),
            ValueListenableBuilder<RoundState>(
              valueListenable: game.status,
              builder: (context, state, _) {
                if (state == RoundState.running) return const SizedBox.shrink();
                return RoundOverlay(
                  state: state,
                  elapsed: game.elapsed.value,
                  best: best,
                  newBest: newBest,
                  finishedAll:
                      state == RoundState.won && widget.level == maxLevel,
                  hasNextLevel: widget.level < maxLevel,
                  onResume: game.resumeRound,
                  onNext: () =>
                      context.pushReplacement(KeoRoutes.game(widget.level + 1)),
                  onRestart: _restart,
                  onHome: () => context.go(KeoRoutes.home),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Hud extends StatelessWidget {
  const _Hud({required this.level, required this.game});

  final int level;
  final KeoGame game;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          KeoPanel(
            radius: 14,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
            child: Text(
              t.levelLabel(level),
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: KeoColors.ink,
                fontSize: 14.sp,
              ),
            ),
          ),
          ValueListenableBuilder<double>(
            valueListenable: game.elapsed,
            builder: (context, value, _) => KeoPanel(
              radius: 14,
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
              child: Text(
                t.secondsShort(value.toStringAsFixed(1)),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: KeoColors.ink,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          IconButton.filled(
            onPressed: game.pauseRound,
            icon: const Icon(Icons.pause),
            tooltip: t.pause,
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
}

class _GoalBanner extends StatelessWidget {
  const _GoalBanner({required this.game});

  final KeoGame game;

  String _text(AppLocalizations t) {
    if (game.reachedEnd.value) return t.goalReturn;
    return t.goalGo(game.crossed.value, game.lineY.length);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return ListenableBuilder(
      listenable: Listenable.merge([game.reachedEnd, game.crossed]),
      builder: (context, _) => KeoPanel(
        radius: 30,
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
        child: Text(
          _text(t),
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: KeoColors.ink,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
