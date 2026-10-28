# Mỗi file dưới 300 dòng code

Một file Dart trong `lib/` và `test/` không vượt 300 dòng code. Dòng trống và dòng comment `//` không tính. File sinh tự động được bỏ qua.

Khi file sắp vượt, tách trước khi thêm code:

1. Mỗi widget lớn một file, tên `snake_case` theo tên widget.
2. Màn hình là thư mục: `xxx_screen.dart` chỉ ghép bố cục, phần con nằm trong `widgets/`.
3. Hàm `_buildXxx()` dài thì đổi thành `StatelessWidget` ở file riêng.
4. Widget dùng ở nhiều màn hình đưa vào `lib/app/widgets/` hoặc `lib/widgets/`, mỗi widget một file.
5. Logic không phải giao diện tách sang `lib/core/`.
6. Khi tách: truyền dữ liệu và callback qua tham số, giữ nguyên hành vi.

File cũ đã vượt chuẩn ghi trong `legacyCeilings` của `test/rules/file_size_test.dart`, với trần bằng số dòng lúc thêm rule. Trần chỉ được hạ, không tăng, không thêm file mới. Khi file giảm, test báo phải hạ trần hoặc xóa khỏi danh sách.

Đếm tay: `grep -vE '^\s*($|//)' lib/path/file.dart | wc -l`

Kiểm tra tự động: `test/rules/file_size_test.dart`.
