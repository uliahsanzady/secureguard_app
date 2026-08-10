@echo off
echo ========================================
echo    SecureGuard Git Commit ^& Push
echo ========================================
echo.
set /p commit_message="Masukkan pesan commit: "

git add .
git commit -m "%commit_message%"
git push origin main

echo.
echo ✅ Commit dan Push berhasil!
echo.
pause