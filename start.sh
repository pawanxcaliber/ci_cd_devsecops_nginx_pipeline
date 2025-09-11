#!/bin/sh

# Start Flask backend with Gunicorn
gunicorn -w 4 -b 0.0.0.0:5000 app:app --chdir /app/backend &

# Start NGINX
nginx -g "daemon off;"
