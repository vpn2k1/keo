# CLAUDE.md

@docs/AGENTS.md

## Rules (nạp mọi phiên)

@rules/no-ternary.md
@rules/file-size.md
@rules/naming.md
@rules/structure.md
@rules/localization.md
@rules/responsive-ui.md
@rules/dependencies.md
@rules/workflow.md
@rules/git.md

## Cấu trúc hiện tại của dự án này

Dự án đi trước khi có `rules/`, nên khác mẫu trong `rules/structure.md`:

| rules/structure.md | keo_mobile |
| --- | --- |
| `lib/features/<tên>/` | `lib/screens/` (màn hình) + `lib/screens/widgets/` |
| widget dùng chung | `lib/ui/` (gom lại qua `lib/ui/keo_ui.dart`) |
| `lib/core/` (Dart thuần) | `lib/core/` (luật ván, bảng màn, nhân vật) |
| — | `lib/game/keo_game.dart` (vòng lặp Flame) |
| `lib/l10n/strings.dart` | `lib/l10n/app_vi.arb` + `flutter gen-l10n` |
| `features/<tên>/state/` | `lib/state/` (provider Riverpod dùng chung) |

Điều hướng: `go_router` khai báo trong `lib/app/keo_routes.dart`; màn hình chỉ gọi
`context.push(KeoRoutes.xxx)`. Màn chơi là `/game/:level`.
Câu chữ: thêm vào `lib/l10n/app_vi.arb` rồi `flutter gen-l10n`, dùng `AppLocalizations.of(context)`.
Kích thước: dùng `.w/.h/.sp/.r` của `flutter_screenutil` (mẫu 390x844).

`test/rules/` của base đã bật: toán tử 3 ngôi, số dòng, tên file, `lib/core/`
không import Flutter. Chạy `dart format lib test` trước khi test.
Độ khó từng màn nằm trong bảng `levelTable` ở `lib/core/level_config.dart`.

## Skill và agent

`.claude/skills/`: `new-feature`, `add-dependency`, `split-large-file`, `verify-flutter`.
`.claude/agents/`: `flutter-reviewer`.

## Lệnh

```bash
flutter pub get
dart format lib test
flutter analyze
flutter test
```

Trả lời người dùng bằng tiếng Việt, trừ khi họ yêu cầu khác.
