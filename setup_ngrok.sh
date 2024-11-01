#!/bin/bash

# Variables
SCRIPT_NAME="start_ngrok.sh"
SERVICE_NAME="ngrok.service"
SERVICE_DIR="/etc/systemd/system"
BIN_DIR="/usr/local/bin"
LOG_FILE="/home/pk/ngrok.service.log"

# Functions
function log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1"
}

# Move the start_ngrok.sh script to /usr/local/bin
if [ -f "$SCRIPT_NAME" ]; then
    log "Moving $SCRIPT_NAME to $BIN_DIR..."
    sudo cp "$SCRIPT_NAME" "$BIN_DIR/"
    sudo chmod +x "$BIN_DIR/$SCRIPT_NAME"
    log "$SCRIPT_NAME has been moved and made executable."
else
    log "Error: $SCRIPT_NAME not found!"
    exit 1
fi

# Move the ngrok.service file to /etc/systemd/system
if [ -f "$SERVICE_NAME" ]; then
    log "Moving $SERVICE_NAME to $SERVICE_DIR..."
    sudo cp "$SERVICE_NAME" "$SERVICE_DIR/"
    log "$SERVICE_NAME has been moved."
else
    log "Error: $SERVICE_NAME not found!"
    exit 1
fi

# Enable the ngrok service
log "Enabling $SERVICE_NAME..."
sudo systemctl enable "$SERVICE_NAME"

# Start the ngrok service
log "Starting $SERVICE_NAME..."
if sudo systemctl start "$SERVICE_NAME"; then
    log "$SERVICE_NAME started successfully."
else
    log "Failed to start $SERVICE_NAME."
    exit 1
fi

# Check the status of the ngrok service
log "Checking the status of $SERVICE_NAME..."
if sudo systemctl status "$SERVICE_NAME"; then
    log "$SERVICE_NAME is running."
else
    log "Error: $SERVICE_NAME is not running!"
    exit 1
fi

log "Setup completed successfully."
