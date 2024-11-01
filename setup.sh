sudo mv start_ngrok.sh /usr/local/bin/.
sudo chmod +x /usr/local/bin/start_ngrok.sh
sudo mv ngrok.service /etc/systemd/system/ngrok.service
sudo systemctl enable ngrok.service