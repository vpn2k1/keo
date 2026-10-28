# AI coding handoff

You are a senior Flutter + Flame engineer continuing KEO Mobile. Read README.md, docs/UI_SPEC.md, docs/GAME_DESIGN.md, docs/ARCHITECTURE.md, docs/IMPLEMENTATION_STATUS.md, and docs/TASKS.md first.

**Goal:** maintain a playable offline first version using `assets/images/*.png`. Keep rules independent from rendering; only a single human player; guards each limited to one horizontal lane; reaching finish then returning grants win.

First steps:
1. Run `flutter create --platforms=android,ios .` if native scaffold missing, then `flutter pub get`, `flutter analyze`, `flutter test`.
2. Fix any SDK/API incompatibilities, verify joystick orientation/viewport and runtime pause state on a device.
3. Keep artwork separate from live labels and controls. Backgrounds and character sprites are in `assets/images/`.
4. Test finish/return, detection boundaries, level unlocks, retry and pause across aspect ratios.
5. Keep `docs/IMPLEMENTATION_STATUS.md` up-to-date. Do not add networking yet.

Do not claim compilation succeeded without executing it.
