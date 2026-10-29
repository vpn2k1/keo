# Cách dùng bộ mẫu này cho dự án mới

Mẫu này gồm: `AGENTS.md` và `CLAUDE.md` (hướng dẫn cho agent), `rules/` (quy ước bắt buộc), `docs/` (tài liệu giải thích), `.claude/` (skill và agent), `test/rules/` (test tự động kiểm tra quy ước).

## Tạo dự án mới từ mẫu

1. Tạo dự án Flutter: `flutter create <tên> --empty`.
2. Chép từ mẫu: `AGENTS.md`, `CLAUDE.md`, `rules/`, `docs/`, `.claude/`, `test/rules/`, `analysis_options.yaml`, `lib/app/`, `lib/core/`, `lib/features/home/` (nếu muốn ví dụ), `lib/l10n/strings.dart`.
3. Đổi tên package trong `import 'package:flutter_base/...'` thành tên dự án.
4. Xóa `rules/` nào không áp dụng (ví dụ `responsive-ui.md` nếu không dùng kích thước theo constraint). Sửa danh sách `@rules/...` trong `CLAUDE.md` cho khớp.
5. Chạy `dart format lib test && flutter analyze && flutter test`.

## Khi quy tắc đã có sẵn trong dự án cũ

Với dự án đã có nhiều code, test sẽ báo các chỗ vi phạm. Có hai cách:

- **Sửa dần:** đưa file đang vượt vào `legacyCeilings` (test/rules/file_size_test.dart) với trần bằng số dòng hiện tại, rồi chia nhỏ dần. Trần chỉ được hạ.
- **Sửa hết một lượt:** chỉ khi dự án nhỏ, và làm trong một PR riêng không kèm tính năng.

Toán tử 3 ngôi: sửa theo từng file, không để test đỏ lâu. Dùng skill `split-large-file` cho file lớn.

## Thêm quy tắc mới

1. Viết `rules/<tên>.md`, ngắn, dạng mệnh lệnh.
2. Thêm `@rules/<tên>.md` vào `CLAUDE.md`.
3. Nếu quy tắc kiểm tra được bằng máy, thêm test vào `test/rules/`.
4. Giải thích lý do trong `docs/`, không trong `rules/`.

## Vì sao tách `rules/` và `docs/`

- `rules/` được nạp vào mọi phiên làm việc của agent, nên phải ngắn. Mỗi dòng tốn ngữ cảnh.
- `docs/` dài, viết cho người đọc. Không được import vào `CLAUDE.md`.
