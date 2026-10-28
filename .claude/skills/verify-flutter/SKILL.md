---
name: verify-flutter
description: Kiểm tra chất lượng dự án Flutter (format, analyze, test, quy ước trong rules/). Dùng sau mỗi thay đổi code hoặc khi người dùng hỏi "kiểm tra dự án".
---

# Kiểm tra dự án Flutter

Chạy từ thư mục gốc dự án.

## Các bước

1. Lấy dependency nếu chưa có: `flutter pub get`.
2. Định dạng: `dart format lib test`. Bắt buộc trước test toán tử 3 ngôi.
3. Phân tích tĩnh: `flutter analyze`. Báo mọi lỗi và cảnh báo mới.
4. Test: `flutter test`. Báo số pass/fail, đính kèm lỗi nếu có. Gồm cả `test/rules/` (toán tử 3 ngôi, số dòng, tên file, phụ thuộc tầng).
5. Báo kết quả theo mẫu:
   - Format: có file nào bị đổi không
   - Analyze: số lỗi và cảnh báo
   - Test: số pass và fail
   - Không kiểm tra được: liệt kê rõ (ví dụ layout trên thiết bị)

Không sửa code trong skill này. Nếu phát hiện lỗi, báo lại và hỏi người dùng có muốn sửa không.
