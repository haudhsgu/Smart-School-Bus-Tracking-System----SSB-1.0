# 🐳 Hướng dẫn sử dụng Docker

## Yêu cầu
- Docker Desktop đã được cài đặt và đang chạy
- Docker Compose (thường đi kèm với Docker Desktop)

## Các bước chạy project với Docker

### 1. Chuẩn bị file .env
```bash
# Copy file .env.example thành .env
cp .env.example .env
```

Sau đó chỉnh sửa các giá trị trong file `.env` theo nhu cầu của bạn.

### 2. Build và chạy containers
```bash
# Build và chạy tất cả services
docker compose up --build

# Hoặc chạy ở chế độ background
docker compose up -d --build
```

### 3. Truy cập ứng dụng
- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:5000
- **Database**: localhost:3306

### 4. Xem logs
```bash
# Xem logs của tất cả services
docker compose logs -f

# Xem logs của một service cụ thể
docker compose logs -f backend
docker compose logs -f frontend
docker compose logs -f db
```

### 5. Dừng và xóa containers
```bash
# Dừng containers
docker compose stop

# Dừng và xóa containers
docker compose down

# Xóa cả volumes (dữ liệu database sẽ bị mất)
docker compose down -v
```

## Các lệnh Docker hữu ích

### Chạy Prisma migrations
```bash
docker compose exec backend npx prisma migrate dev
```

### Truy cập Prisma Studio
```bash
docker compose exec backend npx prisma studio
```

### Truy cập shell trong container
```bash
# Backend
docker compose exec backend sh

# Database
docker compose exec db mysql -u root -p
```

### Reset database
```bash
docker compose exec backend npx prisma db push --force-reset
```

## Troubleshooting

### Port đã được sử dụng
Nếu gặp lỗi port đã được sử dụng, thay đổi các biến `FRONTEND_PORT`, `BACKEND_PORT`, hoặc `MYSQL_PORT` trong file `.env`.

### Database connection failed
- Đảm bảo database container đã khởi động hoàn toàn (kiểm tra bằng `docker compose logs db`)
- Kiểm tra `DATABASE_URL` trong file `.env` có đúng không

### Frontend không kết nối được Backend
- Kiểm tra `VITE_API_URL` trong file `.env`
- Đảm bảo backend container đang chạy: `docker compose ps`

## Môi trường Development

Để chạy ở chế độ development với hot-reload:

1. Tạo file `docker-compose.dev.yml`:
```yaml
version: '3.8'

services:
  backend:
    command: npm run dev
    volumes:
      - ./packages/backend:/app
      - /app/node_modules
    environment:
      NODE_ENV: development
```

2. Chạy với:
```bash
docker compose -f docker-compose.yml -f docker-compose.dev.yml up
```

## Cấu trúc Docker

- **db**: MySQL 8.0 container cho database
- **backend**: Node.js container chạy Express API
- **frontend**: Nginx container phục vụ React app đã build
- **ssb-network**: Private network để các containers giao tiếp với nhau
- **mysql_data**: Volume lưu trữ dữ liệu database

## Bảo mật

⚠️ **Quan trọng**: Đừng commit file `.env` lên Git. Luôn thay đổi các giá trị mặc định trong production:
- `JWT_SECRET`
- `MYSQL_ROOT_PASSWORD`
- `MYSQL_PASSWORD`
