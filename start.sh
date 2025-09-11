#!/bin/sh

# Start the Python app in the background
python3 /app/backend/app.py &

# Start NGINX in the foreground
nginx -g 'daemon off;'