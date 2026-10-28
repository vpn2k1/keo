# Quy tắc đặt tên

Theo [Effective Dart](https://dart.dev/effective-dart/style). Các mục dưới đây là phần dự án bắt buộc thêm.

## File và thư mục

| Đối tượng | Quy tắc | Ví dụ |
|---|---|---|
| File Dart | `snake_case.dart` | `score_banner.dart` |
| File test | `<tên>_test.dart`, đặt trong `test/` theo cấu trúc `lib/` | `test/core/score_calculator_test.dart` |
| Thư mục | `snake_case`, số ít cho một khái niệm, số nhiều cho nhóm | `features/home/`, `widgets/` |
| Màn hình | `<feature>_screen.dart` | `home_screen.dart` |

Không đặt tên file theo kiểu `Home_Screen.dart`, `homeScreen.dart` hay `home-screen.dart`.

## Định danh trong code

| Đối tượng | Quy tắc | Ví dụ |
|---|---|---|
| Class, enum, typedef, extension | `UpperCamelCase` | `ScoreBanner`, `GradeLevel` |
| Biến, hàm, tham số, hằng số | `lowerCamelCase` | `calculateScore`, `maxRetry` |
| Thành viên private | Tiền tố `_` | `_labelColor` |
| Biến `bool` | Bắt đầu bằng `is`, `has`, `can`, `should` | `isLoading`, `hasError` |
| Hàm trả về `Widget` (không phải class) | Danh từ hoặc `buildXxx` | `_board(n)`, `_buildHeader()` |
| Widget | Danh từ mô tả, không thêm hậu tố `Widget` | `ScoreBanner`, không phải `ScoreBannerWidget` |
| State của StatefulWidget | `_<WidgetName>State` | `_HomeScreenState` |
| Provider (nếu dùng Riverpod) | `<tên>Provider` | `scoreProvider` |
| Khóa chuỗi giao diện | `lowerCamelCase`, mô tả nội dung | `playNow`, `scoreLabel` |

Tên viết tắt: chỉ dùng các viết tắt phổ biến (`id`, `url`, `api`, `ui`). Tên đầy đủ nếu không chắc.

## Nguyên tắc chung

- Tên nói rõ việc làm hoặc thứ là gì. Tránh `data`, `info`, `temp`, `manager`, `helper` khi có tên cụ thể hơn.
- Một khái niệm một tên xuyên suốt code: nếu gọi là `score` thì không đổi thành `points` ở chỗ khác.
- Hàm bắt đầu bằng động từ: `calculateScore`, `loadProfile`.
- Tên test mô tả hành vi, theo ngôn ngữ của dự án: `'gradeFor xếp loại theo ngưỡng'`.

Kiểm tra tự động: `test/rules/naming_test.dart` kiểm tra tên file.
