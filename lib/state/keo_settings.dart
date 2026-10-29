import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Cài đặt người chơi, lưu trong SharedPreferences.
class KeoSettings {
  const KeoSettings({
    required this.music,
    required this.sound,
    required this.vibration,
  });

  final bool music;
  final bool sound;
  final bool vibration;

  KeoSettings copyWith({bool? music, bool? sound, bool? vibration}) =>
      KeoSettings(
        music: music ?? this.music,
        sound: sound ?? this.sound,
        vibration: vibration ?? this.vibration,
      );
}

const _defaults = KeoSettings(music: true, sound: true, vibration: true);

class SettingsNotifier extends AsyncNotifier<KeoSettings> {
  @override
  Future<KeoSettings> build() async {
    final p = await SharedPreferences.getInstance();
    return KeoSettings(
      music: p.getBool('music') ?? true,
      sound: p.getBool('sound') ?? true,
      vibration: p.getBool('vibration') ?? true,
    );
  }

  KeoSettings get _current => state.value ?? _defaults;

  // Lưu ngay mỗi lần gạt để thoát bằng nút back không mất thay đổi.
  Future<void> _set(String key, bool value, KeoSettings next) async {
    state = AsyncData(next);
    final p = await SharedPreferences.getInstance();
    await p.setBool(key, value);
  }

  Future<void> setMusic(bool v) =>
      _set('music', v, _current.copyWith(music: v));

  Future<void> setSound(bool v) =>
      _set('sound', v, _current.copyWith(sound: v));

  Future<void> setVibration(bool v) =>
      _set('vibration', v, _current.copyWith(vibration: v));
}

final settingsProvider = AsyncNotifierProvider<SettingsNotifier, KeoSettings>(
  SettingsNotifier.new,
);
