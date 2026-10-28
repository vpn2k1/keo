# Không dùng toán tử 3 ngôi

Không viết `điều_kiện ? a : b` trong `lib/` và `test/`. Dùng `if` + `return` trong hàm nhỏ, `if` trong collection, hoặc `if/else`.

```dart
// Sai
color: selected ? ink : muted,

// Đúng
color: _labelColor(selected),

Color _labelColor(bool selected) {
  if (selected) return ink;
  return muted;
}
```

- Lồng nhau: viết chuỗi `return` sớm, không lồng toán tử.
- Chọn widget: hàm trả `Widget`, hoặc `if` trong danh sách `children`.
- Không né rule bằng `switch` trên `bool` hay map `{true: a, false: b}[x]`.

Được phép: `??`, `?.`, `if` trong collection literal, `if/else`.

Lưu ý: toán tử 3 ngôi chỉ tính nhánh được chọn. Nếu một nhánh có tác dụng phụ hoặc dùng `x!` chỉ an toàn ở một nhánh, viết `if` trực tiếp.

Kiểm tra tự động: `test/rules/no_ternary_test.dart`. Chạy `dart format` trước khi test.
