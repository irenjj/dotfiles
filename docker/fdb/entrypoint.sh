#!/bin/bash

sudo echo "RSAAuthentication yes" >> /etc/ssh/sshd_config
sudo echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config 
sudo echo "AuthorizedKeysFile .ssh/authorized_keys" >> /etc/ssh/sshd_config 
sudo echo "PermitRootLogin yes" >> /etc/ssh/sshd_config 

sudo /usr/sbin/sshd -D

tail -f /dev/null
