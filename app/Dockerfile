FROM node:18
WORKDIR /app
COPY . .
RUN npm install
CMD ["sh", "-c", "while true; do node index.js || sleep 1; done"]

HEALTHCHECK --interval=10s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1
