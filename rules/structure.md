# Cấu trúc thư mục và chia lớp

```
lib/
  main.dart              điểm vào, chỉ gọi runApp
  app/                   gốc ứng dụng: App, theme, routing, widget dùng chung toàn app
  core/                  logic thuần Dart, KHÔNG import package:flutter
  features/<tên>/        mỗi tính năng một thư mục
    <tên>_screen.dart    màn hình, chỉ ghép bố cục
    widgets/             widget con của tính năng
    state/               (nếu có) Notifier/Provider của tính năng
  l10n/                  câu chữ giao diện (xem localization.md)
test/
  rules/                 test tự động kiểm tra quy ước (không đổi tên thư mục này)
  core/                  test logic thuần
  features/              test màn hình và widget, theo cấu trúc lib/
```

## Hướng phụ thuộc

- `features/` được import `core/`, `app/`, `l10n/`.
- `core/` chỉ import Dart thuần và `core/` khác. Không import `features/`, `app/` hay `package:flutter`.
- Một feature không import feature khác. Phần dùng chung đưa lên `app/` hoặc `core/`.
- `app/` không biết chi tiết feature, chỉ biết màn hình đầu tiên và cách điều hướng.

Kiểm tra tự động: `test/rules/architecture_test.dart` kiểm tra `core/` không import Flutter.

## Chia nhỏ

- Mỗi file dưới 300 dòng code (xem [file-size.md](file-size.md)).
- Một widget lớn một file. Widget 5–10 dòng chỉ dùng một chỗ thì để trong file cha.
- Màn hình chỉ ghép bố cục. Logic (tính toán, gọi dữ liệu) nằm trong `core/` hoặc `state/`.
- Khi thêm tính năng mới, bắt đầu từ `features/<tên>/` theo mẫu skill `new-feature`.
