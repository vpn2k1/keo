# Kích thước giao diện

Mặc định dự án không dùng package ngoài để co giãn. Layout tính từ constraint:

- Dùng `AspectRatio`, `Expanded`, `Flexible`, `LayoutBuilder`, `size.shortestSide`. Không hardcode chiều rộng khối theo pixel.
- Khung nội dung giới hạn bằng `ConstrainedBox(maxWidth: ...)` để không kéo giãn trên tablet.
- Khoảng cách và cỡ chữ lấy từ `Theme` khi có thể. Hằng số khoảng cách đặt một chỗ, không rải rác.
- Dùng `SafeArea` cho phần đệm hệ thống. Không dùng `MediaQuery` để tính layout chính.

Nếu dự án chọn `flutter_screenutil`, ghi lại trong [docs/tech-stack.md](../docs/tech-stack.md) và thay các hằng số bằng `.w`, `.h`, `.sp` đồng nhất.

Kiểm tra: chạy trên màn hình hẹp (khoảng 360 px chiều rộng) và màn hình lớn trước khi merge. Không có test tự động.
