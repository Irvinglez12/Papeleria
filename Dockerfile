# Etapa 1: Build del frontend
FROM node:20 AS build-frontend

WORKDIR /app

COPY src/ ./src
COPY package*.json ./

RUN npm install
RUN npm run build

# Etapa 2: Backend que sirve el frontend
FROM node:20

WORKDIR /app

# Copiar backend
COPY backend/server.js ./
COPY backend/routes ./routes
COPY backend/middleware ./middleware  
COPY .env ./
COPY package*.json ./

RUN npm install

# Copiar frontend build
COPY --from=build-frontend /app/dist ./public

EXPOSE 5000
CMD ["node", "server.js"]
