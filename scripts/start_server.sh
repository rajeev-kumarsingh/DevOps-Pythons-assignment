#!/bin/bash
set -e

echo "Starting Flask Application..."

APP_DIR="/home/ubuntu/flask_app"
PORT=80
LOG_FILE="$APP_DIR/server.log"

# Navigate to the application directory
cd "$APP_DIR" || { echo "Failed to enter $APP_DIR"; exit 1; }

# Activate virtual environment (if used)
if [ -d "venv" ]; then
    source venv/bin/activate
fi

# Install dependencies (optional, if not installed)
pip install -r requirements.txt

# Start Flask application in the background
nohup python3 web.py > "$LOG_FILE" 2>&1 &

echo "Flask Application started successfully on port $PORT."
