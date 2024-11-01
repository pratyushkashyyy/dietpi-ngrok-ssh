#!/bin/bash

# Define your webhook URL here
WEBHOOK_URL="https://hook.us1.make.com/3ard4i462w19jgt2bt8etkyirzb14ar"  #setup a webhook for notification on make.com

# Create a named pipe
PIPE=/tmp/ngrok_pipe
mkfifo $PIPE

# Start ngrok and redirect output to the named pipe
ngrok tcp 22 --log=stdout > $PIPE &

# Allow some time for Ngrok to initialize
sleep 10

# Function to extract the URL and send it to the webhook
send_webhook() {
    while read line; do
        # Check for the line containing the URL
        if echo "$line" | grep -q "url="; then
            # Extract the URL from the line
            URL=$(echo "$line" | awk -F 'url=' '{print $2}' | xargs) # Remove leading/trailing whitespace
            
            if [[ -n "$URL" ]]; then
                echo "Extracted Ngrok URL: $URL"

                # Send the new URL to the webhook
                response=$(curl -X POST -H "Content-Type: application/json" -d "{\"checkout_url\": \"$URL\"}" "$WEBHOOK_URL" 2>&1)

                # Check for successful curl execution
                if [[ $? -eq 0 ]]; then
                    echo "Webhook notification sent successfully."
                else
                    echo "Failed to send webhook notification. Response: $response"
                fi
            fi
        fi
    done < $PIPE
}

# Start the function in the background to process the Ngrok output
send_webhook &

# Wait for Ngrok to finish
wait %1

# Cleanup
rm $PIPE