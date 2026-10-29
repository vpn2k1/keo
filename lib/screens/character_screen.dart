import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../app/keo_routes.dart';
import '../core/game_character.dart';
import '../l10n/app_localizations.dart';
import '../state/keo_character.dart';
import '../ui/keo_ui.dart';

class CharacterScreen extends ConsumerWidget {
  const CharacterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final selected = ref.watch(characterProvider).value ?? GameCharacter.keo;
    return KeoPage(
      heading: t.characterSelect,
      children: [
        for (final character in GameCharacter.all) ...[
          _CharacterRow(
            character: character,
            selected: character.id == selected.id,
            onTap: () => ref.read(characterProvider.notifier).select(character),
          ),
          SizedBox(height: 12.h),
        ],
        SizedBox(height: 8.h),
        KeoButton(
          title: t.playNow,
          onPressed: () => context.push(KeoRoutes.game(1)),
        ),
      ],
    );
  }
}

class _CharacterRow extends StatelessWidget {
  const _CharacterRow({
    required this.character,
    required this.selected,
    required this.onTap,
  });

  final GameCharacter character;
  final bool selected;
  final VoidCallback onTap;

  Color get _color {
    if (selected) return KeoColors.yellow;
    return KeoColors.beige;
  }

  @override
  Widget build(BuildContext context) => Semantics(
        selected: selected,
        child: KeoPanel(
          color: _color,
          padding: EdgeInsets.zero,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/${character.idleImage()}',
                    width: 80.w,
                    height: 92.h,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Text(
                      character.name,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w900,
                        color: KeoColors.ink,
                      ),
                    ),
                  ),
                  if (selected)
                    Icon(Icons.check_circle, color: KeoColors.ink, size: 24.sp),
                ],
              ),
            ),
          ),
        ),
      );
}
