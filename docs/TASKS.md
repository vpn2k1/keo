# TASKS — Execution checklist

Quy ước: `[ ]` chưa làm; `[x]` đã làm và xác minh; `[!]` blocked hoặc làm khác kế hoạch (ghi lý do).

## Phase 0 — Bootstrap

- [x] Khởi tạo dự án Flutter, kiểm tra môi trường và phiên bản Flutter/Dart (Flutter 3.44.8).
- [x] Thêm Flame stable tương thích và dependency lưu cục bộ.
- [!] Tạo cấu trúc thư mục theo `ARCHITECTURE.md` — giữ cấu trúc gọn hiện tại (`game/round_rules.dart`, `game/level_config.dart`); tách thêm khi code lớn lên.
- [x] Thiết lập portrait và GameWidget, scaffold Home.
- [x] Chạy `flutter analyze` và `flutter test` thành công.

## Phase 1 — Playable

- [x] Vẽ sân và 5 vạch với tọa độ world.
- [x] Tạo player và joystick, normalize movement vector (`relativeDelta` của joystick có độ dài ≤ 1).
- [x] Chặn player ở ranh giới sân.
- [x] Tạo Guard component và tuần tra ngang bằng `dt`.
- [x] Đảm bảo mỗi guard luôn giữ Y cố định.
- [x] Implement collision chính xác (tổng bán kính, có unit test).
- [x] Implement outbound → returning → won và lost.
- [x] Lock gameplay khi kết thúc, retry reset toàn bộ.
- [ ] Test ít nhất 1 round thắng, 1 round thua trên emulator/device.

## Phase 2 — UX

- [x] Home/Play/Pause/Resume/Result/Retry.
- [x] HUD thông báo tiến về đích (kèm số vạch đã vượt) hoặc quay về.
- [x] Tự pause khi app chạy nền; nút Back Android khi đang chơi sẽ tạm dừng.
- [x] Bố cục dựng lại trên bộ art `assets/images/` (title/menu/field): SafeArea, Spacer và LayoutBuilder thay cho toạ độ cố định; chưa xem trực tiếp trên thiết bị.
- [x] Điều hướng gom về named route trong `lib/app/keo_routes.dart`.
- [ ] Hướng dẫn người mới trong game (hiện chỉ có màn Cách chơi).

## Phase 3 — Levels & save

- [x] LevelConfig có validation.
- [x] 10 level config, không trùng logic (cần playtest để chỉnh độ khó).
- [x] Level Select và mở khóa sau khi thắng.
- [x] Lưu tiến trình offline (màn đã mở, kỷ lục thời gian).
- [ ] Kiểm tra đóng/mở app vẫn giữ tiến trình trên thiết bị.

## Phase 4 — QA & release readiness

- [x] Thay 9 mockup chứa chữ/nút bằng 5 ảnh sạch: nền tiêu đề, nền menu, sân, sprite người chơi và người canh; test tải màn chơi.
- [x] Thêm tư thế chạy và tuần tra; nhân vật đổi góc nhìn khi chạy lên, người canh quay đầu; kiểm tra pause/reset giữ đúng khung hình.
- [x] Test unit cho collision, rule state, AI bounds, unlock, kỷ lục, level config.
- [x] Test widget Home → Chọn màn và Cài đặt. [ ] Result chưa có widget test.
- [x] Chạy `flutter analyze` không error.
- [x] Chạy `flutter test` thành công (14 test).
- [ ] Test joystick và gameplay trên thiết bị Android.
- [!] Build APK: Gradle không tải được thư viện trong môi trường sandbox, cần build lại trên máy có mạng.
- [x] Kiểm tra iOS build: `flutter build ios --simulator --debug` thành công; chạy thử trên iPhone simulator (thua, chơi lại, tự pause khi ra nền).
- [x] README cập nhật lệnh chạy.

## Thông tin tiến độ

- Updated: 2026-10-28.
- Blockers: chưa có âm thanh (không có file audio).
- Next action: chơi thử trên thiết bị (chưa có simulator/máy nào kết nối), chỉnh độ khó theo playtest.
