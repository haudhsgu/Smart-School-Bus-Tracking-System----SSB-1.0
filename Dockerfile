# --- GIAI ĐOẠN 1: Dựng Frontend (Đặt tên là builder) ---
FROM node:18-alpine AS builder
WORKDIR /app/frontend

# 1. Chui vào thư mục frontend để cài đặt
COPY packages/frontend/package*.json ./
RUN npm install

# 2. Copy code frontend và Build ra file tĩnh
COPY packages/frontend/ .
RUN npm run build
# ⚠️ QUAN TRỌNG: Kiểm tra xem lệnh này tạo ra thư mục tên là 'dist' hay 'build'
# (Vite thường ra 'dist', React cũ ra 'build')


# --- GIAI ĐOẠN 2: Dựng Backend và GỘP ---
FROM node:18-alpine
WORKDIR /app

# 3. Chui vào thư mục backend cài đặt
COPY packages/backend/package*.json ./
RUN npm install

# 4. Copy toàn bộ code backend
COPY packages/backend/ .

# 🔥 ĐÂY LÀ LỆNH GỘP MÀY CẦN 🔥
# Lấy thư mục 'dist' từ giai đoạn 'builder' ở trên
# Copy ném vào thư mục 'public' của thằng backend hiện tại
COPY --from=builder /app/frontend/dist ./public
# (Nếu ở trên build ra folder tên là 'build' thì sửa 'dist' thành 'build')

# 5. Mở port và chạy
EXPOSE 5173
CMD ["npm", "start"]