---
name: add-dependency
description: Thêm hoặc nâng cấp một thư viện Flutter/Dart đúng quy trình của dự án (flutter pub add, dev hay runtime, lưu pubspec.lock, kiểm tra). Dùng khi người dùng yêu cầu thêm gói hoặc cân nhắc một thư viện.
---

# Thêm thư viện

Đọc [rules/dependencies.md](../../../rules/dependencies.md) trước.

## Các bước

1. **Xác định nhu cầu cụ thể.** Nếu có thể làm bằng Dart thuần vài dòng, đề xuất làm vậy và dừng lại hỏi người dùng.
2. **Chọn gói** trong [docs/tech-stack.md](../../../docs/tech-stack.md) nếu có. Nếu không, tìm trên pub.dev: kiểm tra số lượt dùng, cập nhật gần đây, số lỗi đã biết.
3. **Thêm bằng lệnh:**
   - Runtime: `flutter pub add <gói>`
   - Chỉ build hoặc test: `flutter pub add dev:<gói>`
4. **Kiểm tra:** `dart format lib test`, `flutter analyze`, `flutter test`.
5. **Ghi lại:** cập nhật bảng trong `docs/tech-stack.md` với lý do thêm gói. Nếu thay đổi hành vi người dùng thấy được, cập nhật `CHANGELOG.md`.
6. **Báo cáo:** tên gói, phiên bản đã cài, vì sao cần, file đã đổi (`pubspec.yaml`, `pubspec.lock`, tài liệu).

## Không làm

- Không sửa `pubspec.yaml` bằng tay.
- Không nâng hàng loạt nhiều gói trong cùng một thay đổi với tính năng.
- Không thêm gói "phòng khi cần".
