---
name: new-feature
description: Tạo một tính năng mới theo cấu trúc features/<tên>/ của dự án Flutter (màn hình, widget con, logic trong core/, chuỗi trong Strings, test). Dùng khi người dùng yêu cầu thêm màn hình hoặc tính năng mới.
---

# Thêm tính năng mới

Đọc [rules/structure.md](../../../rules/structure.md) và [rules/naming.md](../../../rules/naming.md) trước.

## Các bước

1. **Đặt tên** theo `naming.md`: thư mục `features/<tên_snake_case>/`, màn hình `<tên>_screen.dart`, class `<Tên>Screen`.
2. **Logic thuần** (tính toán, quy tắc, xử lý dữ liệu) đặt trong `lib/core/<tên>.dart`. File này không import Flutter.
3. **Màn hình** `lib/features/<tên>/<tên>_screen.dart`: chỉ ghép bố cục, gọi logic từ `core/`.
4. **Widget con** trong `lib/features/<tên>/widgets/`, mỗi widget một file.
5. **Chuỗi hiển thị** thêm vào `lib/l10n/strings.dart` dưới dạng `static const` lowerCamelCase. Không viết chuỗi trong widget.
6. **Test**:
   - Logic: `test/core/<tên>_test.dart`.
   - Màn hình: `test/features/<tên>/<tên>_screen_test.dart` với `testWidgets`.
7. **Điều hướng**: nếu có route mới, thêm vào `lib/app/app.dart` (hoặc file routing khi dự án có).
8. **Kiểm tra** theo skill `verify-flutter`.
9. **Báo cáo**: danh sách file mới, file đã sửa, kết quả kiểm tra. Không commit khi người dùng chưa yêu cầu.

## Lưu ý

- Không để feature import feature khác. Phần dùng chung đưa lên `app/` hoặc `core/`.
- Nếu một file sắp vượt 300 dòng, tách ngay theo skill `split-large-file`.
- Không toán tử 3 ngôi (`rules/no-ternary.md`).
