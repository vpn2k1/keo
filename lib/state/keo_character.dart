import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/game_character.dart';

/// Nhân vật người chơi đã chọn, lưu trong SharedPreferences.
class CharacterNotifier extends AsyncNotifier<GameCharacter> {
  @override
  Future<GameCharacter> build() async {
    final p = await SharedPreferences.getInstance();
    return GameCharacter.fromId(p.getString(GameCharacter.selectedKey));
  }

  Future<void> select(GameCharacter character) async {
    state = AsyncData(character);
    final p = await SharedPreferences.getInstance();
    await p.setString(GameCharacter.selectedKey, character.id);
  }
}

final characterProvider =
    AsyncNotifierProvider<CharacterNotifier, GameCharacter>(
  CharacterNotifier.new,
);
