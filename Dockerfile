# ... (Phần Giai đoạn 1 Build Frontend giữ nguyên) ...

# --- GIAI ĐOẠN 2: Dựng Backend và GỘP ---
FROM node:18-alpine AS builder
WORKDIR /app

# 3. Chui vào thư mục backend cài đặt
COPY packages/backend/package*.json ./
RUN npm install

# 4. Copy toàn bộ code backend
COPY packages/backend/ .

# 🔥 THÊM DÒNG NÀY VÀO ĐÂY (Sau bước Copy code) 🔥
# Để nó đọc schema và tạo client cho Linux
RUN npx prisma generate

# ... (Phần Copy Frontend và CMD giữ nguyên) ...
COPY --from=builder /app/frontend/dist ./public

EXPOSE 5173
CMD ["npm", "start"]