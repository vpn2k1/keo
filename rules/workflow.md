# Quy trình sau khi sửa code

Sau mỗi thay đổi trong `lib/` hoặc `test/`, chạy theo thứ tự:

1. `dart format lib test`. Bắt buộc, vì test toán tử 3 ngôi phụ thuộc vào định dạng.
2. `flutter analyze`. Không để lỗi mới, cảnh báo mới cũng phải sửa.
3. `flutter test`. Mọi test pass, gồm test trong `test/rules/`.

Báo lại kết quả thật của từng bước. Nếu bước nào không chạy được, nói rõ lý do.

Quy tắc về thay đổi:

- Chỉ sửa file liên quan đến thay đổi. Không format lại file không liên quan.
- Không tự commit hoặc push khi người dùng chưa yêu cầu.
- Không sửa file sinh tự động bằng tay. Sửa nguồn rồi sinh lại.
- Thay đổi hành vi người dùng thấy được: cập nhật `CHANGELOG.md`.
