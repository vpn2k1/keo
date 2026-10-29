# Tech stack và thư viện — KEO

Game offline Flutter + Flame. Không có backend, không quảng cáo, không Firebase
(xem guardrail trong [AGENTS.md](AGENTS.md)). Phiên bản ràng buộc nằm trong
[pubspec.yaml](../pubspec.yaml); thêm gói bằng `flutter pub add`.

## 1. Nền tảng

| Hạng mục | Công nghệ |
| --- | --- |
| Framework | Flutter (Dart SDK `>=3.4.0 <4.0.0`) |
| Game engine | Flame |
| Nền tảng đích | Android, iOS (portrait) |

## 2. Thư viện đang dùng

| Thư viện | Vai trò | Dùng ở đâu |
| --- | --- | --- |
| `flame` | Vòng lặp game, sprite, joystick | `lib/game/keo_game.dart` |
| `flutter_riverpod` | State + nạp/lưu dữ liệu người chơi | `lib/state/` |
| `go_router` | Điều hướng khai báo | `lib/app/keo_routes.dart` |
| `flutter_screenutil` | Co giãn kích thước theo màn hình (`.w`, `.h`, `.sp`, `.r`) | `lib/ui/`, `lib/screens/` |
| `flutter_localizations` + `intl` | Sinh `AppLocalizations` từ ARB | `lib/l10n/` |
| `shared_preferences` | Lưu tiến trình, kỷ lục, cài đặt | `lib/state/` |
| `audioplayers` | Nhạc nền và hiệu ứng | `lib/app/keo_audio.dart` |
| `package_info_plus` | Hiện phiên bản trong Cài đặt | `lib/state/app_info.dart` |

Dev: `flutter_lints`, `flutter_launcher_icons`, `flutter_native_splash`.

## 3. Lệnh thường dùng

```bash
flutter pub get
flutter gen-l10n                       # sau khi sửa lib/l10n/app_vi.arb
dart format lib test && flutter analyze && flutter test
dart run flutter_launcher_icons        # sau khi đổi assets/icon/app_icon.png
dart run flutter_native_splash:create  # sau khi đổi ảnh splash
```

## 4. Câu chữ giao diện

Mọi chuỗi hiển thị nằm trong `lib/l10n/app_vi.arb`, dùng qua
`AppLocalizations.of(context)`. Không viết chuỗi tiếng Việt trong widget.
Tên nhân vật (`Kéo`, `Mai`, `Nam`) là dữ liệu trong `lib/game/game_character.dart`.

## 5. Âm thanh

`assets/audio/` hiện là file tạm do script tổng hợp (sóng vuông/sin), chỉ để
chạy thử: `win.wav`, `lose.wav`, `tap.wav`, `music.mp3`. Thay bằng file thật khi
có, giữ nguyên tên là không phải sửa code.

## 6. Không đưa vào dự án

Firebase, AdMob, `in_app_update`, Shorebird: cần tài khoản ngoài và trái
guardrail "offline, không backend, không monetization". Nếu đổi hướng, sửa
[AGENTS.md](AGENTS.md) trước rồi mới thêm gói.
