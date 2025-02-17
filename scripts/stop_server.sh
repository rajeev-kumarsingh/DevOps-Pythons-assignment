#!/bin/bash

# Exit immediately if any command fails
set -e 

echo "Stopping Flask Application..."

# Define application directory and port
APP_DIR="/home/ubuntu/flask_app"
PORT=5000

# Find process ID (PID) of the application running on the specified port
PID=$(lsof -t -i:$PORT || true)

if [ -n "$PID" ]; then
    echo "Killing process $PID running on port $PORT..."
    kill -9 "$PID"
    echo "Flask application stopped successfully."
else
    echo "No Flask application is running on port $PORT."
fi
