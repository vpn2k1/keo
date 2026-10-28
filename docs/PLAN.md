# PLAN — KEO Offline MVP

## Quy tắc thực hiện

Hoàn thành tuần tự các phase. Mỗi phase có *deliverables* và *exit criteria*. Chỉ đánh dấu xong khi đã kiểm tra; nếu không chạy được do thiếu SDK, ghi `BLOCKED` trong `TASKS.md`.

## Phase 0 — Bootstrap

**Mục tiêu:** app Flutter chạy được với Flame.

**Việc làm:** khởi tạo repo Flutter; thêm `flame` và thư viện local storage phù hợp; bật lint; tạo folder modules; scaffold menu và `GameWidget`; khóa orientation portrait trên mobile; kiểm tra API tương thích phiên bản đã cài.

**Bàn giao:** chạy được Home → sân trống → Back.

**Exit:** `flutter analyze` không lỗi; `flutter test` chạy được; mở app không crash.

## Phase 1 — Vertical slice playable

**Mục tiêu:** 1 level end-to-end thực sự chơi được.

**Việc làm:** virtual world 360×640 (có thể điều chỉnh bằng config), sân trong giới hạn, 5 vạch, player, 5 guard AI tuần tra trên X, joystick, collision, state machine, tuyến ra/về, thắng/thua, retry.

**Bàn giao:** chơi hết một ván trên thiết bị/emulator; hình đơn giản, chưa cần art.

**Exit:** guard giữ nguyên Y của vạch; player không vượt biên; va chạm đúng theo radius; có thể thắng/thua/retry liên tiếp; FPS không quyết định tốc độ.

## Phase 2 — UX hoàn chỉnh

**Việc làm:** Home, Pause/Resume, Restart, Results, hướng dẫn ngắn, phản hồi hình ảnh tối thiểu, tắt/bật âm thanh; safe area; joystick không đè sân; có cách quay lại Home.

**Exit:** hoàn chỉnh luồng thao tác bằng cảm ứng, không có màn hình bị kẹt.

## Phase 3 — Level và lưu tiến độ

**Việc làm:** level config chứa `guardCount`, `guardSpeed`, `direction`, `patrolMode`, `spawn`, `goal`, `arena` và các tham số hợp lệ. Tạo 10 level tăng độ khó có kiểm soát. Lưu level cao nhất đã mở và setting vào máy.

**Exit:** hoàn thành level n mở level n+1; đóng/mở app không mất tiến trình; reset progress hoạt động nếu có nút.

## Phase 4 — Polish + QA

**Việc làm:** animation cơ bản, âm thanh, rung (nếu phù hợp), cân bằng tốc độ AI, kiểm tra màn hình nhỏ/dài, pause khi app background, xử lý 60/120 Hz, sửa lỗi va chạm ở dt lớn.

**Exit:** thông qua checklist `ACCEPTANCE_TESTS.md`, build Android release; iOS build nếu có macOS/Xcode; cập nhật README chạy dự án.

## Mốc ngoài MVP — Không triển khai lúc này

- Chơi phòng qua Wi-Fi / online multiplayer.
- Network authority, state sync, lobby, matchmaking.
- Tài khoản, cloud save, vật phẩm, quảng cáo, IAP.

**Chuẩn bị để mở rộng:** giữ domain rules độc lập với Flame/Flutter, controller interface cho `HumanInput`, `AIInput` và `NetworkInput` tương lai. Online sẽ vẫn cần thiết kế lại phần authoritative simulation và đồng bộ trạng thái.
