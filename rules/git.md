# Git và file không commit

- Nhánh từ `main`: `feat/<tên>`, `fix/<tên>`, `docs/<tên>`, `refactor/<tên>`.
- Commit theo [Conventional Commits](https://www.conventionalcommits.org/): `feat:`, `fix:`, `test:`, `docs:`, `refactor:`, `chore:`.
- Không commit: `build/`, `.dart_tool/`, `.idea/`, `*.iml`, `.DS_Store`. Các mục này đã có trong `.gitignore`.
- Commit: `pubspec.lock`.
- Không commit khóa bí mật, file `.env`, tệp cấu hình chứa thông tin tài khoản. Nếu lỡ commit, báo người dùng ngay.
