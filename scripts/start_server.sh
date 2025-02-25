#!/bin/bash
set -e  # Exit script on any command failure

APP_DIR="/home/ubuntu/flask_app"
PORT=80
LOG_FILE="$APP_DIR/server.log"

# Navigate to the application directory
cd "$APP_DIR" || { echo "Failed to enter $APP_DIR"; exit 1; }

# Ensure Python 3 and required packages are installed
if ! command -v python3 &> /dev/null; then
    echo "Python3 is not installed. Installing..."
    sudo apt-get update && sudo apt-get install -y python3 python3-venv python3-pip
fi

# Ensure python3-venv is installed to avoid ensurepip errors
if ! dpkg -l | grep -q python3-venv; then
    echo "Installing python3-venv..."
    sudo apt-get update && sudo apt-get install -y python3-venv
fi

# Create a virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating Python virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
source venv/bin/activate

# Upgrade pip inside the virtual environment
pip install --upgrade pip

# Install dependencies inside the virtual environment
echo "Installing dependencies..."
pip install -r requirements.txt

# Start Flask application in the background
echo "Starting Flask application..."
nohup python3 web.py > "$LOG_FILE" 2>&1 &

# Wait and check if the process is running
sleep 3
if pgrep -f "python3 web.py" > /dev/null; then
    echo "Flask Application started successfully on port $PORT."
else
    echo "Flask Application failed to start. Check logs at $LOG_FILE."
    exit 1
fi
