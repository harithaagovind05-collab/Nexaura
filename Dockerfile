FROM node:22-bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends openjdk-17-jdk-headless && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY client/package*.json client/
RUN cd client && npm install
COPY server/package*.json server/
RUN cd server && npm install --omit=dev
COPY client client
RUN cd client && npm run build
COPY server server
ENV NODE_ENV=production
ENV PORT=5000
EXPOSE 5000
WORKDIR /app/server
CMD ["node", "index.js"]
