---
name: split-large-file
description: Tách một file Dart vượt 300 dòng code thành các file nhỏ (widget con, logic sang core/) mà không đổi hành vi. Dùng khi test file_size báo lỗi hoặc người dùng yêu cầu tách file.
---

# Tách file lớn

Đọc [rules/file-size.md](../../../rules/file-size.md) và [rules/structure.md](../../../rules/structure.md) trước.

## Các bước

1. **Đo** số dòng code: `grep -vE '^\s*($|//)' <file> | wc -l`.
2. **Liệt kê** các phần trong file: widget con, hàm `_buildXxx()`, logic tính toán, hằng số, class private.
3. **Chọn đích** cho từng phần:
   - Widget con dùng một màn hình: `features/<tên>/widgets/<tên>.dart`.
   - Widget dùng nhiều màn hình: `app/widgets/` hoặc `lib/widgets/`.
   - Logic không phải giao diện: `core/`.
4. **Tách từng phần một**, sau mỗi bước chạy `flutter analyze` và `flutter test`.
   - Class private (`_Xxx`) chuyển sang file riêng thì đổi thành public (`Xxx`).
   - Truyền dữ liệu và callback qua tham số constructor, không đọc biến toàn cục.
5. **Cập nhật import** và xóa code không còn dùng.
6. **Kiểm tra** file gốc còn dưới 300 dòng. Nếu file là file cũ trong `legacyCeilings`, hạ trần cho khớp số dòng mới hoặc xóa khỏi danh sách.
7. **Báo cáo:** danh sách file tách ra, số dòng trước và sau. Hành vi không đổi.

## Lưu ý

- Giữ nguyên hành vi: không đổi tên chuỗi, không đổi thứ tự gọi có tác dụng phụ.
- Widget 5–10 dòng chỉ dùng một chỗ thì không cần tách.
- Không tách chỉ để đạt số dòng nếu các phần không liên quan gì đến nhau. Ưu tiên tách theo trách nhiệm.
