# --- GIAI ĐOẠN 1: BUILDER (Frontend) ---
FROM node:18-alpine AS builder  # <--- Dòng bắt đầu Giai đoạn 1
WORKDIR /app/frontend

COPY packages/frontend/package*.json ./
RUN npm install
COPY packages/frontend/ .
RUN npm run build


# --- GIAI ĐOẠN 2: RUNNER (Backend) ---
# 🔥 ÔNG ĐANG THIẾU DÒNG NÀY NÈ 🔥
FROM node:18-alpine 

WORKDIR /app

# Cài đặt backend
COPY packages/backend/package*.json ./
RUN npm install
COPY packages/backend/ .
RUN npx prisma generate

# Copy kết quả từ giai đoạn 1 (builder) sang giai đoạn 2
COPY --from=builder /app/frontend/dist ./public 

# Backend chạy port nào thì expose port đó (ví dụ 3000, không phải 5173 của Vite nhé)
EXPOSE 5173
CMD ["npm", "start"]