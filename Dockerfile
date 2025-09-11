# Stage 1: Build the backend
FROM python:3.9-slim AS backend-builder

WORKDIR /app
COPY api/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY api/ .

# Stage 2: Combine frontend, backend, and NGINX
FROM nginx:1.21.3-alpine AS final

# Install Python and dependencies in the final NGINX image
RUN apk add --no-cache python3 py3-pip

# Copy frontend files from the local filesystem
COPY ui/ /app/ui/

# Copy the NGINX configuration
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# Copy the backend from the builder stage
COPY --from=backend-builder /usr/local/lib/python3.9/site-packages/ /usr/local/lib/python3.9/site-packages/
COPY --from=backend-builder /usr/local/bin/ /usr/local/bin/
COPY --from=backend-builder /app /app

# Expose port 8080 as NGINX will handle all traffic
EXPOSE 8080

# Command to run both services
CMD sh -c "python3 /app/app.py & nginx -g 'daemon off;'"