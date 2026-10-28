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
| `lib/core/` (Dart thuần) | `lib/game/round_rules.dart`, `lib/game/level_config.dart` |
| `lib/l10n/strings.dart` | chưa có — câu chữ còn viết trực tiếp trong widget |

Điều hướng: chỉ dùng named route trong `lib/app/keo_routes.dart`, không gọi
`MaterialPageRoute` trong màn hình. Màn chơi nhận số màn qua `arguments`.

Áp rule cho code mới; không refactor code cũ khi người dùng chưa yêu cầu.
Chưa bật `test/rules/` của base: `lib/game/` còn 6 chỗ dùng toán tử 3 ngôi và
dự án không có `lib/core/` (test architecture sẽ lỗi).

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
