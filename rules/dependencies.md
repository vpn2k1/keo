# Thêm và đổi thư viện

1. **Chỉ thêm khi có nhu cầu cụ thể.** Không thêm gói "để sau này dùng". Danh sách gợi ý nằm trong [docs/tech-stack.md](../docs/tech-stack.md).
2. **Dùng `flutter pub add`**, không sửa `pubspec.yaml` bằng tay. Gói chỉ dùng khi build hoặc test đặt trong `dev_dependencies` (`flutter pub add dev:<tên>`).
3. **Commit cả `pubspec.lock`** để mọi máy dùng cùng phiên bản.
4. **Không thêm gói mà core có thể tự làm** bằng Dart thuần trong vài dòng.
5. **Đọc changelog** khi nâng major, đặc biệt với gói liên quan đến nền tảng (Firebase, quảng cáo, engine game, state management).
6. **Chạy `flutter pub outdated` định kỳ** để biết gói lỗi thời. Không nâng hàng loạt trong cùng một thay đổi với tính năng.
7. **Ghi lý do** vào mô tả PR khi thêm gói mới: gói làm gì, vì sao không tự viết.
