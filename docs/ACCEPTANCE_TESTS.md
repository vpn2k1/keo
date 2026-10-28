# ACCEPTANCE TESTS — KEO

## Luật chơi

| ID | Tình huống | Kết quả mong đợi |
| --- | --- | --- |
| RULE-01 | Player tiến tới START mà chưa tới GOAL | Không thắng |
| RULE-02 | Player vượt qua GOAL | Phase chuyển `returning`, game chưa thắng |
| RULE-03 | Player quay về START sau GOAL | Phase `won`, ngừng simulation |
| RULE-04 | Player chạm guard khi outbound | Phase `lost` |
| RULE-05 | Player chạm guard khi returning | Phase `lost` |
| RULE-06 | Player ở gần guard nhưng hitbox chưa giao | Không lost |
| RULE-07 | Collision và GOAL cùng frame | Thứ tự xử lý được xác định; ưu tiên `lost` nếu đang overlap guard |
| RULE-08 | Retry sau win/loss | Vị trí player, AI, trạng thái, timer reset sạch |

## Di chuyển & AI

| ID | Tình huống | Kết quả mong đợi |
| --- | --- | --- |
| MOVE-01 | Joystick thả | Player dừng |
| MOVE-02 | Joystick chéo | Tốc độ không nhanh hơn đi thẳng |
| MOVE-03 | Player cố đi ra ngoài biên | Bị chặn đúng mép hitbox |
| AI-01 | Guard tuần tra 60 giây | Y luôn bằng lineY đã gán |
| AI-02 | Guard tới biên trái/phải | Đổi chiều, không ra ngoài sân |
| AI-03 | Simulation cùng tổng thời gian ở FPS khác nhau | Vị trí xấp xỉ nhau trong sai số chấp nhận |
| AI-04 | Pause game | Không cập nhật timer, player hoặc guard |

## App & lưu tiến độ

| ID | Tình huống | Kết quả mong đợi |
| --- | --- | --- |
| APP-01 | Mở game offline | Chơi được không cần internet |
| APP-02 | Thắng level 1 | Mở khóa level 2 |
| APP-03 | Thoát và mở lại | Vẫn giữ level đã mở |
| APP-04 | Màn hình hẹp và màn hình dài | Không mất vùng chơi chính hoặc nút điều khiển |
| APP-05 | App chuyển background | Mặc định pause game, không chết bất ngờ |

## Kiểm tra build

- `dart format --output=none --set-exit-if-changed lib test`
- `flutter analyze`
- `flutter test`
- `flutter build apk --release` (khi có Android SDK)
- iOS build chỉ trên macOS/Xcode hợp lệ.

Mỗi lỗi phải được tái hiện và ghi test regression nếu có thể.
