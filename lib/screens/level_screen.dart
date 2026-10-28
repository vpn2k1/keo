import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/keo_routes.dart';
import '../game/round_rules.dart';
import '../ui/keo_ui.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({super.key});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  int unlocked = 1;
  Map<int, double> best = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      unlocked = p.getInt('unlocked') ?? 1;
      best = {
        for (var l = 1; l <= maxLevel; l++)
          if (p.getDouble(bestTimeKey(l)) case final t?) l: t,
      };
    });
  }

  Future<void> _open(int level) async {
    await pushGame(context, level);
    await _load();
  }

  @override
  Widget build(BuildContext context) => KeoPage(
        heading: 'Chọn màn',
        children: [
          KeoPanel(
            child: Text(
              'Đã mở khóa: $unlocked/$maxLevel',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w900,
                color: KeoColors.ink,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Ô màn co theo bề ngang thật, không dùng kích thước cố định.
          LayoutBuilder(
            builder: (context, box) {
              final width = (box.maxWidth - 24) / 3;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  for (var level = 1; level <= maxLevel; level++)
                    SizedBox(
                      width: width,
                      height: width * .88,
                      child: _LevelTile(
                        level: level,
                        locked: level > unlocked,
                        best: best[level],
                        onPressed: () => _open(level),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      );
}

class _LevelTile extends StatelessWidget {
  const _LevelTile({
    required this.level,
    required this.locked,
    required this.best,
    required this.onPressed,
  });

  final int level;
  final bool locked;
  final double? best;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var background = KeoColors.yellow;
    var icon = Icons.star_rounded;
    VoidCallback? tap = onPressed;
    if (locked) {
      background = KeoColors.locked;
      icon = Icons.lock;
      tap = null;
    }
    return ElevatedButton(
      onPressed: tap,
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        disabledBackgroundColor: KeoColors.locked,
        foregroundColor: KeoColors.ink,
        disabledForegroundColor: const Color(0xFF8A8073),
        padding: EdgeInsets.zero,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: KeoColors.brown, width: 2),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 22),
          Text(
            'Màn $level',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
          ),
          if (best case final t?)
            Text('${t.toStringAsFixed(1)}s',
                style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
