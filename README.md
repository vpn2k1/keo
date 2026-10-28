# KEO Mobile — Flutter + Flame (Offline MVP)

A Flutter/Flame game with functional navigation, 5-line offline gameplay, joystick, guarding AI, win/lose logic, unlocked levels, settings storage, and original illustrated artwork.

## Quick start

1. Install Flutter stable (tested with 3.44.8) and Android Studio / Xcode.
2. Run `flutter pub get`.
3. Run `flutter run` (use a simulator or physical device).
4. Run `flutter analyze` and `flutter test`.

Artwork under `assets/images/` includes clean title and menu backgrounds, the playing field, and transparent player and guard sprites. Flutter renders live text and buttons above the backgrounds; Flame renders the field and animated characters.

## Project files

- `lib/` — application, screens, UI components, Flame gameplay.
- `assets/images/` — five PNG game assets.
- `docs/` — project planning, prompts, architecture, gameplay, tasks, QA.
- `android/`, `ios/` — native projects (org `com.keo`, app name "KEO").
- `test/` — rule, level config and widget tests.

## Limitations

- Current AI is horizontal patrol only. Characters have two-frame running and patrol animations, with front/back poses for the player. No music or sound effects (switches shown disabled), no boost. Vibration works.
- No multiplayer or server.
