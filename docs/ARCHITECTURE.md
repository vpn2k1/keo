# ARCHITECTURE — Flutter + Flame

## Nguyên tắc

- UI (Flutter) hiển thị menu/HUD; Flame quản lý rendering và simulation.
- Game rules không phụ thuộc widget hoặc engine API nếu có thể.
- Dùng mô hình dữ liệu `LevelConfig` cho mọi màn.
- **Không** đưa logic core vào file `main.dart`.
- Mọi vị trí/tốc độ dùng tọa độ world nhất quán; camera xử lý scale mà không ảnh hưởng hitbox.

## Cây thư mục đề xuất

```text
lib/
  main.dart
  app/
    keo_app.dart
  screens/
    home_screen.dart
    level_select_screen.dart
    game_screen.dart
  game/
    keo_game.dart
    components/
      arena_component.dart
      player_component.dart
      guard_component.dart
    controllers/
      movement_controller.dart
      joystick_input_controller.dart
      patrol_ai_controller.dart
    models/
      level_config.dart
      arena_config.dart
    domain/
      round_phase.dart
      round_rules.dart
      collision_math.dart
    ui/
      game_hud.dart
      result_overlay.dart
      pause_overlay.dart
  services/
    progress_repository.dart
    local_progress_repository.dart
  config/
    game_constants.dart
    level_catalog.dart

test/
  game/domain/round_rules_test.dart
  game/domain/collision_math_test.dart
  game/controllers/patrol_ai_controller_test.dart
  game/models/level_config_test.dart
  services/progress_repository_test.dart
```

## Contracts đề xuất

- `RoundPhase`: `ready`, `outbound`, `returning`, `won`, `lost`, `paused`.
- `LevelConfig`: `id`, `arena`, `startArea`, `goalArea`, `guardConfigs`, `playerSpeed`.
- `GuardConfig`: `lineY`, `initialX`, `speed`, `initialDirection`, `radius`.
- `MovementController`: tạo movement intent theo mỗi frame; không trực tiếp ghi vào domain state.
- `RoundRules`: input vị trí player, guards, trigger areas; output state transition/event.
- `ProgressRepository`: abstract methods `load`, `saveUnlockedLevel`, `saveSettings`.

## Frame loop

```text
Input (joystick / AI) 
  → movement intent 
  → integrate with dt + clamp to arena 
  → update collision geometry 
  → evaluate round rules 
  → emit event to Flutter HUD / overlays
```

Khi game kết thúc: khóa input/simulation hoặc bỏ qua movement update; không dispatch lặp event.

## Thiết kế cho online về sau

- Trạng thái game phải có thể serialize (positions, directions, phase, level state).
- Có ranh giới giữa input và simulation.
- Không buộc domain vào mạng hoặc UI.
- Khi làm online, cần server-authoritative game state, prediction/interpolation, reconciliation và anti-cheat ở phase riêng; interface offline **không tự động đảm bảo** online hoạt động.

## Dependency policy

- Flutter stable, Dart null safety, Flame stable version tương thích.
- Persistence nhẹ: `shared_preferences` hoặc giải pháp offline tương đương được duyệt.
- Tránh thêm state management package trước khi thực sự cần; ValueNotifier/Flutter primitives đủ cho MVP.
- Pin versions phù hợp trong `pubspec.lock` và ghi lý do khi nâng cấp.
