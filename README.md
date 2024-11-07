# dietpi-ngrok-ssh

##SETUP
Run setup_ngrok.sh
and follow below instructions

## Change this setting in sshconfig file and make sure these lines are uncommented

Port 22

PermitRootLogin no

PasswordAuthentication yes

PubkeyAuthentication yes


## make sure this line exists in /etc/hosts

127.0.0.1 localhost


## for notification use make.com and setup telegram bot 

