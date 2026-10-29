import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/keo_settings.dart';

/// Phát nhạc nền và hiệu ứng, tự bỏ qua khi người chơi tắt trong Cài đặt.
/// Player chỉ được tạo lúc thật sự phát, và mọi lỗi phát đều nuốt: thiếu plugin
/// hay thiết bị không phát được cũng không làm hỏng ván chơi.
class KeoAudio {
  KeoAudio(this._ref);

  final Ref _ref;
  AudioPlayer? _sfx;
  AudioPlayer? _music;

  KeoSettings? get _settings => _ref.read(settingsProvider).value;

  Future<void> win() => _play('audio/win.wav');
  Future<void> lose() => _play('audio/lose.wav');
  Future<void> tap() => _play('audio/tap.wav');

  Future<void> _play(String asset) async {
    if (_settings?.sound != true) return;
    try {
      final player = _sfx ??= AudioPlayer();
      await player.stop();
      await player.play(AssetSource(asset));
    } on Exception {
      _sfx = null;
    }
  }

  Future<void> startMusic() async {
    if (_settings?.music != true) return;
    try {
      final player = _music ??= AudioPlayer();
      await player.setReleaseMode(ReleaseMode.loop);
      await player.play(AssetSource('audio/music.mp3'), volume: .4);
    } on Exception {
      _music = null;
    }
  }

  Future<void> stopMusic() async {
    try {
      await _music?.stop();
    } on Exception {
      _music = null;
    }
  }

  Future<void> dispose() async {
    try {
      await _sfx?.dispose();
      await _music?.dispose();
    } on Exception {
      // Không còn gì để dọn.
    }
  }
}

final audioProvider = Provider<KeoAudio>((ref) {
  final audio = KeoAudio(ref);
  ref.onDispose(audio.dispose);
  return audio;
});
