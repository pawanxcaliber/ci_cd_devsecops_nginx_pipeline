# Stage 1: Build backend dependencies
FROM python:3.9-slim AS backend-builder

WORKDIR /app
COPY api/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY api/ .

# Stage 2: Final image with NGINX + Backend
FROM nginx:1.21.3-alpine AS final

# Install Python + pip
RUN apk add --no-cache python3 py3-pip

# Set up backend
WORKDIR /app/backend
COPY api/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt gunicorn
COPY api/ .

# Install security tools
RUN pip install --no-cache-dir bandit

# Copy frontend files
COPY ui/ /app/ui/

# Copy NGINX configuration
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# Copy startup script from project root → container /app/
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Expose port for NGINX
EXPOSE 8080

# Run both backend (Gunicorn) + frontend (NGINX)
CMD ["/app/start.sh"]
