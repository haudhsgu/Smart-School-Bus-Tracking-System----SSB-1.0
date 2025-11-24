@echo off
echo ====================================
echo   KẾT NỐI VÀO DATABASE SSB10
echo ====================================
echo.
echo Đang kết nối vào MySQL...
echo Username: ssbuser
echo Database: ssb10
echo.

docker compose exec db mysql -u ssbuser -pssbpassword ssb10

if %errorlevel% neq 0 (
    echo.
    echo ❌ Không thể kết nối! 
    echo.
    echo Vui lòng kiểm tra:
    echo 1. Docker Desktop có đang chạy không
    echo 2. Containers có đang chạy: docker compose ps
    echo.
)

pause
