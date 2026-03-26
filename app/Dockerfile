FROM node:18
WORKDIR /app
COPY . .
RUN npm install
CMD ["node","index.js"]

HEALTHCHECK --interval=10s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1
