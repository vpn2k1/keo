# Câu chữ giao diện và đa ngôn ngữ

Quy tắc hằng ngày nằm trong [rules/localization.md](../rules/localization.md). Tài liệu này mô tả cách chuyển sang đa ngôn ngữ khi cần.

## Mẫu đơn giản (đang dùng)

Mọi chuỗi nằm trong `lib/l10n/strings.dart`, truy cập qua `Strings.xxx`. Một ngôn ngữ, không cần sinh mã.

## Mẫu nhiều ngôn ngữ (khi cần)

Nguồn duy nhất là một script, sinh ra ARB và lớp `Strings`:

```
tool/gen_strings.py   (key → (ngôn ngữ 1, ngôn ngữ 2))
   ├──► lib/l10n/app_<lang>.arb        (ARB chuẩn)
   └──► lib/l10n/strings.dart          (lớp Strings tĩnh)
            └──► flutter gen-l10n  →  AppLocalizations
```

Quy trình:

1. Thêm hoặc sửa câu trong script, không sửa tay `strings.dart` và file ARB.
2. Chạy `python3 tool/gen_strings.py && flutter gen-l10n`.
3. Dùng `Strings.key` hoặc `Strings.key(arg)` trong widget.
4. Biến dùng `{tên}`, không nối chuỗi trong UI.
5. Ngôn ngữ mặc định phải khớp ở mọi nơi khai báo (`template-arb-file`, giá trị khởi tạo `Strings`, nhánh mặc định của hàm chọn ngôn ngữ).

Test: kiểm tra đổi ngôn ngữ và một màn hình hẹp trong `test/features/`.
