# Implementation status

## Included
- [x] Original PNG backgrounds and animated character poses
- [x] Flutter entrypoint and app theme, portrait lock
- [x] Splash (tap to skip), home, level select, tutorial, settings, gameplay, pause, victory/defeat overlays
- [x] Flame game loop, 5 lines, mobile joystick, circle contact using the radius sum
- [x] `LevelConfig` with validation: 3 guards on level 1, 4 on levels 2–3, 5 from level 4, harder start points from level 7
- [x] Reach end and return-to-start win logic; HUD shows lines crossed
- [x] Auto-pause when the app goes to the background; Android back pauses instead of leaving mid-round
- [x] SharedPreferences: unlocked levels, best time per level, vibration setting (saved on toggle)
- [x] Result overlay shows time and best time; "Phá đảo 10 màn!" after level 10
- [x] Vibration on win/lose (`HapticFeedback`, respects the setting)
- [x] Native Android/iOS scaffolding (`flutter create`, org `com.keo`, app name "KEO")
- [x] Unit tests for rules, patrol bounds, unlock, best time, level config; widget tests for level select and settings
- [x] `flutter analyze` and `flutter test` pass (Flutter 3.44.8)

## Not yet verified / not implemented
- [ ] File âm thanh thật (hiện là file tạm tự tổng hợp trong `assets/audio/`)
- [x] Two-frame running and guard patrol animation; directional front/back player poses
- [ ] Tile maps and expanded animation states
- [ ] Hand-tuned difficulty per level (current curve needs playtesting)
- [ ] Final device review of the new artwork across aspect ratios
- [ ] Gameplay test on a real device or emulator
- [x] `dart format lib test` (toàn bộ code đã format lại)
- [ ] Multiplayer (future phase only)
