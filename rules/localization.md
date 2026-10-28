# Câu chữ giao diện qua `Strings`

- Mọi chuỗi người dùng thấy (tiêu đề, nhãn, nút, thông báo, nội dung popup, nhãn Semantics) khai báo trong `lib/l10n/strings.dart`.
- Widget chỉ tham chiếu `Strings.xxx`. Không viết chuỗi tiếng Việt hay tiếng Anh trực tiếp trong `lib/features/` và `lib/app/`.
- Chuỗi có tham số là hàm: `static String scoreOf(int value) => 'Điểm: $value';`.
- Chuỗi kỹ thuật (tên route, khóa lưu trữ, mã định danh) không phải câu chữ hiển thị, được phép viết trực tiếp.
- Giữ dấu đầy đủ.

Khi dự án cần đa ngôn ngữ, xem [docs/localization.md](../docs/localization.md) để chuyển sang ARB và `flutter gen-l10n`. Cấu trúc gọi `Strings.xxx` giữ nguyên khi chuyển.

Kiểm tra tự động: không có. Khi review, tìm chuỗi có dấu trong `lib/features/` và `lib/app/`.
