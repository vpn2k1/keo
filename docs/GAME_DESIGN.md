# GAME DESIGN — KEO

## Trải nghiệm cốt lõi

Người chơi quan sát nhịp tuần tra, nhử người canh lệch vị trí, chọn đúng thời điểm vượt vạch, rồi quay về mà không bị bắt. Mỗi ván ngắn, dễ chơi lại.

## Sân

- Portrait 2D, góc nhìn từ trên xuống.
- Mặc định 5 vạch ngang, từ gần đích đến gần nơi xuất phát.
- AI chỉ di chuyển ngang trên vạch được gán; không rời vạch.
- Người chơi tự do di chuyển trong lòng sân; góc sân và joystick không gây cản trở nhìn.

## Luật chuẩn MVP

1. Bắt đầu ở vùng START bên dưới vạch thấp nhất.
2. Trạng thái `playing_outbound`: vượt tất cả vạch và chạm vùng GOAL phía trên vạch cao nhất.
3. Trạng thái `playing_return`: quay ngược và chạm vùng START.
4. Nếu chạm một người canh ở bất kỳ phase chơi nào → LOST tức thì.
5. Chạm START trước khi từng đến GOAL không tính thắng.
6. Trong WON/LOST/PAUSED, mô phỏng ngừng và UI cung cấp tiếp tục/chơi lại tùy trạng thái.
7. Không giới hạn thời gian ở phiên bản đầu; có thể đo thời gian chơi để hiển thị kết quả.

## Điều khiển

- Joystick ảo ở phần dưới, ngoài hoặc chồng lên HUD nhưng không che đường AI.
- Vector normalize để tốc độ chạy chéo không nhanh hơn chạy thẳng.
- Thả joystick → ngừng di chuyển ngay.
- Không có dash, shield hoặc power-up trong MVP.

## AI v1

- `PatrolGuard`: tự động chạy từ ranh trái đến ranh phải rồi đổi chiều; tốc độ khác nhau theo level.
- Mỗi AI bắt đầu ở vị trí X được config, Y cố định trên vạch.
- Tất cả movement phụ thuộc delta time (`dt`).
- Không teleport, không đổi vạch, không đi ngoài sân.
- Sau này có thể thêm `TrackingGuard` dự đoán hướng nhưng không cần cho level 1.

## Collision

- Hitbox mặc định là hình tròn, dùng tổng bán kính (hoặc hệ collision Flame tương đương) để xác nhận giao nhau.
- Một va chạm chỉ sinh ra một sự kiện thua.
- Đảm bảo không gây va chạm giả do scale render hoặc khoảng cách hiển thị.

## Mức độ khó (gợi ý, cần playtest)

| Level | Số guard | Tốc độ tương đối | Ghi chú |
| --- | ---: | --- | --- |
| 1 | 3 | Chậm | Làm quen, tutorial |
| 2–3 | 4 | Chậm–vừa | Nhịp khác nhau |
| 4–6 | 5 | Vừa | Đúng 5 vạch chuẩn |
| 7–8 | 5 | Vừa–nhanh | Điểm bắt đầu guard khó hơn |
| 9–10 | 5 | Nhanh | Cần căn nhịp |

**Lưu ý:** màn tiêu chuẩn có 5 vạch, nhưng level hướng dẫn có thể bật chỉ 3–4 guard và giữ các vạch còn lại như vạch trống. Nếu muốn đồng nhất 5 AI ở tất cả màn, chỉ thay đổi tốc độ thay vì số guard. Chốt quyết định khi playtest.

## UX / HUD

- Home: logo KEO, nút Chơi, Chọn màn, Cài đặt.
- In-game: trạng thái `ĐI TỚI ĐÍCH` / `QUAY VỀ`, số vạch vượt được, pause.
- Result: Thắng/Thua, thời gian, Thử lại, Màn tiếp theo (khi thắng), Về menu.
- Không hiện thông tin số lượng vạch như điều kiện thắng riêng (điểm thắng do trigger GOAL/START xác định).

## Scope exclusions

Không có online, co-op, skill đặc biệt, bảng xếp hạng, lootbox, skin shop, quảng cáo trong bản MVP.
