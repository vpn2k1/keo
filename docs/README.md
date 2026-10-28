# KEO Mobile — Project documentation

Game mobile 2D góc nhìn từ trên xuống, tái hiện trò **Keo**: người chơi vượt nhiều vạch ngang có người canh di chuyển trái/phải, sau đó quay về vị trí xuất phát.

**Mục tiêu:** bản offline MVP bằng Flutter + Flame, Android trước, iOS sau. Không backend, không multiplayer ở MVP.

## Bộ tài liệu

1. [`PROMPT.md`](PROMPT.md) — Prompt tổng để đưa cho AI coding agent.
2. [`PLAN.md`](PLAN.md) — Lộ trình triển khai theo phase với điều kiện hoàn thành.
3. [`GAME_DESIGN.md`](GAME_DESIGN.md) — Luật, điều khiển, AI, difficulty, UX.
4. [`ARCHITECTURE.md`](ARCHITECTURE.md) — Cấu trúc code, ranh giới module và hướng mở rộng online.
5. [`TASKS.md`](TASKS.md) — Checklist thực thi theo thứ tự.
6. [`ACCEPTANCE_TESTS.md`](ACCEPTANCE_TESTS.md) — Các ca kiểm thử bắt buộc.
7. [`AGENTS.md`](AGENTS.md) — Quy tắc dành cho coding agent làm việc trong repo.

## Cách dùng với AI coding

- Đặt toàn bộ file vào thư mục gốc repository.
- Đưa nội dung `PROMPT.md` cho AI coding agent (Cursor, Claude Code, Codex...).
- AI phải đọc `AGENTS.md`, `GAME_DESIGN.md`, `ARCHITECTURE.md`, `PLAN.md`, `TASKS.md`, `ACCEPTANCE_TESTS.md` trước khi code.
- Mỗi phase: triển khai, chạy `flutter analyze` và `flutter test`, cập nhật `TASKS.md`, ghi nhận vấn đề còn lại.

## Phạm vi cố định

- 1 người chơi offline vs 5 AI canh vạch.
- 1 màn chơi hoàn chỉnh đầu tiên, rồi mở thành 10 level bằng cấu hình.
- Joystick cảm ứng, hỗ trợ debug trên desktop bằng bàn phím (không bắt buộc cho phát hành).
- Người chơi phải tới đích rồi trở lại điểm xuất phát mà không bị chạm.
- Không có đăng nhập, quảng cáo, cửa hàng, năng lượng hay tính năng online.

**Lưu ý:** kiểm tra phiên bản Flutter/Flame tương thích tại thời điểm khởi tạo dự án, không gắn cứng một phiên bản chưa xác minh.
