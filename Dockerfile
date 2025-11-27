# --- GIAI ĐOẠN 1: BUILDER (Frontend) ---
# 👇 Đổi alpine thành slim
FROM node:18-slim AS builder
WORKDIR /app/frontend

COPY packages/frontend/package*.json ./
RUN npm install
COPY packages/frontend/ .
RUN npm run build


# --- GIAI ĐOẠN 2: RUNNER (Backend) ---
# 👇 Đổi alpine thành slim
FROM node:18-slim

# 👇 Thêm dòng này để cài OpenSSL cho Prisma (QUAN TRỌNG)
RUN apt-get update -y && apt-get install -y openssl

WORKDIR /app

# Cài đặt backend
COPY packages/backend/package*.json ./
RUN npm install

# Copy code backend
COPY packages/backend/ .

# Tạo Prisma Client (Nó sẽ tự nhận diện môi trường Slim mới này)
RUN npx prisma generate

# Copy kết quả build Frontend sang
COPY --from=builder /app/frontend/dist ./public

EXPOSE 3000
CMD ["npm", "start"]