# MASTER PROMPT — KEO Mobile (Flutter + Flame)

Bạn là senior Flutter/Flame game developer và technical lead. Hãy **triển khai thật** game 2D mobile tên **KEO — Vượt Phòng Tuyến** theo các tài liệu trong repository, không chỉ trả lời mô tả hoặc pseudo-code.

## Bối cảnh

KEO lấy cảm hứng từ trò chơi tuổi thơ: sân có nhiều vạch ngang song song; mỗi vạch có một người canh chỉ được chạy trái/phải dọc vạch; người chạy tìm cách vượt tất cả vạch mà không bị chạm. Ở chế độ chuẩn, người chạy phải đến đầu bên kia sân và quay về điểm xuất phát.

## Tài liệu ưu tiên

Đọc theo thứ tự: `AGENTS.md` → `GAME_DESIGN.md` → `ARCHITECTURE.md` → `PLAN.md` → `TASKS.md` → `ACCEPTANCE_TESTS.md`. Nếu có mâu thuẫn: ưu tiên luật gameplay trong `GAME_DESIGN.md`, ràng buộc kỹ thuật trong `ARCHITECTURE.md`, thứ tự triển khai trong `PLAN.md`.

## Mục tiêu hiện tại

Xây dựng **offline MVP**, chạy được trên Android và có cấu trúc hỗ trợ iOS. Dùng **Flutter + Flame Engine**, Dart null-safety. Chọn phiên bản dependency stable tương thích SDK thực tế, tra API tài liệu/package hiện hành; không tự suy diễn API Flame cũ.

## Đặc tả bắt buộc

1. Màn hình dọc; một sân 2D top-down hiển thị trọn sân, co giãn theo tỷ lệ thiết bị.
2. Người chơi là nhân vật xanh, canh vạch đỏ (placeholder vẽ bằng component, chưa cần ảnh sprite).
3. Joystick cảm ứng cho phép di chuyển 8 hướng/trơn, dừng khi thả.
4. Năm AI, mỗi AI đứng trên đúng một vạch và chỉ thay đổi tọa độ X; không đi ra ngoài ranh giới sân.
5. AI giai đoạn đầu tuần tra qua lại; có thể cấu hình tốc độ và kiểu hành vi theo level.
6. Chỉ bắt khi hitbox nhân vật và AI thực sự giao nhau; không phạt khi chỉ ở gần.
7. Chạm AI: trạng thái LOST. Tới đích: chuyển phase RETURNING. Quay lại vùng xuất phát: WON.
8. Khi WON/LOST không di chuyển, không cho phát hiện trùng sự kiện; hiển thị nút chơi lại.
9. Có Home → Play → Result/Retry; ít nhất một level chơi trọn vẹn, sau đó mở 10 level config.
10. Tiến trình level lưu cục bộ. Game phải chơi offline hoàn toàn.

## Kiến trúc

- Phân tách `rules/domain`, `game/components`, `game/controllers`, `screens`, `services`.
- Không đưa toàn bộ game vào `main.dart`.
- Controller độc lập với điều khiển nhân vật; tách movement intent khỏi cách tạo intent (joystick/AI). Dự trù network controller sau này, **không triển khai online**.
- Logic thắng/thua là state machine tường minh: `ready`, `playing_outbound`, `playing_return`, `won`, `lost`, `paused`.
- Collision và luật chơi có thể test mà không cần màn hình Flutter.
- Sử dụng fixed virtual world coordinates, tính layout viewport nhất quán; xử lý resize/orientation an toàn.
- Dùng cấu hình level dạng dữ liệu, không hardcode 10 bản game khác nhau.

## Quy trình bắt buộc

1. Kiểm tra repository hiện tại và toolchain (`flutter --version`, `dart --version` nếu được).
2. Đưa ra cây file dự kiến ngắn gọn, sau đó **thực hiện ngay phase đầu**; không hỏi lại các quyết định đã chốt.
3. Thêm code thực, assets vẽ bằng primitive nếu chưa có đồ họa.
4. Thêm unit/widget tests phù hợp và kiểm tra `flutter analyze`, `flutter test`.
5. Ghi lệnh chạy thật, đánh dấu hạng mục xong trong `TASKS.md`, nêu rõ kiểm thử nào chưa thực hiện được.
6. Không thêm backend, Firebase, ads, in-app purchases, leaderboard online, multiplayer hoặc animation phức tạp vào MVP.
7. Nếu toolchain không sẵn có, vẫn tạo source có cấu trúc, chỉ rõ các lệnh cần chạy và **không tuyên bố đã build/test**.

## Kết quả cần bàn giao

- Source code Flutter/Flame biên dịch được (nếu môi trường có SDK).
- Tài liệu lệnh chạy/debug/build.
- Unit tests cho luật thắng/thua, giới hạn AI trong vạch, collision, restart.
- `TASKS.md` phản ánh tiến độ thực tế.

## Yêu cầu về chất lượng

- Code dễ đọc, tách lớp rõ, không dùng magic numbers rải rác.
- Các tốc độ, bán kính hitbox, kích thước sân được đặt ở config.
- `dt` (delta time) nhất quán, tránh di chuyển phụ thuộc FPS.
- Không tạo các feature ngoài MVP để làm lệch tiến độ.

**Hành động đầu tiên:** đọc toàn bộ tài liệu và thực hiện Phase 0 rồi Phase 1 trong `PLAN.md`.
