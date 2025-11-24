# 🔌 Hướng dẫn kết nối Database

## 📊 Thông tin kết nối

### Từ bên ngoài Docker (MySQL Workbench, DBeaver, etc.)
```
Host: localhost (hoặc 127.0.0.1)
Port: 3307
Username: ssbuser
Password: ssbpassword
Database: ssb10
```

### Từ Backend (bên trong Docker)
```
Host: db
Port: 3306
Username: ssbuser
Password: ssbpassword
Database: ssb10

Connection String: mysql://ssbuser:ssbpassword@db:3306/ssb10
```

## 🛠️ Kết nối với MySQL Workbench

1. Mở MySQL Workbench
2. Click "+" để tạo connection mới
3. Điền thông tin:
   - Connection Name: SSB Docker
   - Hostname: `localhost`
   - Port: `3307`
   - Username: `ssbuser`
   - Password: `ssbpassword` (click "Store in Keychain")
4. Click "Test Connection"
5. Click "OK" để lưu

## 🛠️ Kết nối với DBeaver

1. Mở DBeaver
2. Click "New Database Connection"
3. Chọn "MySQL"
4. Điền thông tin:
   - Host: `localhost`
   - Port: `3307`
   - Database: `ssb10`
   - Username: `ssbuser`
   - Password: `ssbpassword`
5. Click "Test Connection"
6. Click "Finish"

## 💻 Kết nối từ Command Line

### Windows PowerShell
```powershell
# Kết nối vào container
docker compose exec db mysql -u ssbuser -p

# Nhập password: ssbpassword
# Sau đó chọn database
USE ssb10;
SHOW TABLES;
```

### Kết nối trực tiếp từ host
```bash
mysql -h localhost -P 3307 -u ssbuser -p
# Nhập password: ssbpassword
```

## 🔍 Kiểm tra kết nối

### Kiểm tra database có đang chạy không
```powershell
docker compose ps
```

### Xem logs database
```powershell
docker compose logs db
```

### Test kết nối từ backend
```powershell
docker compose exec backend npx prisma db pull
```

### Kết nối vào MySQL shell trong container
```powershell
docker compose exec db mysql -u root -prootpassword
```

## ⚠️ Troubleshooting

### Lỗi: "Can't connect to MySQL server"
1. Kiểm tra Docker Desktop có đang chạy không
2. Kiểm tra containers có đang chạy: `docker compose ps`
3. Kiểm tra port 3307 có bị chiếm không: `netstat -an | findstr 3307`

### Lỗi: "Access denied for user"
- Đảm bảo username và password đúng
- Username: `ssbuser`
- Password: `ssbpassword`
- Root password: `rootpassword`

### Lỗi: "Unknown database 'ssb10'"
```powershell
# Tạo lại database
docker compose exec db mysql -u root -prootpassword -e "CREATE DATABASE IF NOT EXISTS ssb10;"
docker compose exec db mysql -u root -prootpassword -e "GRANT ALL PRIVILEGES ON ssb10.* TO 'ssbuser'@'%';"
```

## 📝 Ghi chú quan trọng

- **Port 3307**: Dùng khi kết nối từ máy tính (host)
- **Port 3306**: Dùng khi kết nối từ bên trong Docker network
- Backend tự động kết nối qua Docker network (db:3306)
- File `.env` chứa `DATABASE_URL` cho kết nối từ host (localhost:3307)

## 🔐 Bảo mật

⚠️ **Lưu ý**: Passwords mặc định chỉ dùng cho development. Hãy thay đổi trong production!

```env
# Thay đổi trong file .env
MYSQL_ROOT_PASSWORD=your-strong-password-here
MYSQL_PASSWORD=your-strong-password-here
JWT_SECRET=your-super-secret-jwt-key-here
```
