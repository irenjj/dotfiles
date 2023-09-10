#!/bin/bash

echo "source /opt/rh/devtoolset-11/enable" >> /home/renjj/.bashrc
echo "source /opt/rh/rh-python38/enable" >> /home/renjj/.bashrc
echo "source /opt/rh/rh-ruby27/enable" >> /home/renjj/.bashrc
echo "export CC=/opt/rh/devtoolset-11/root/bin/gcc" >> /home/renjj/.bashrc
echo "export CXX=/opt/rh/devtoolset-11/root/bin/g++" >> /home/renjj/.bashrc
echo "PS1='\[\e[37;40m\][\[\e[32;40m\]\u\[\e[37;40m\]@\h \[\e[36;40m\]\W\[\e[0m\]]\\$ '" >> /home/renjj/.bashrc
source /home/renjj/.bashrc

echo "source /home/renjj/work/tools/gdbplugins/peda/peda.py" >> /home/renjj/.gdbinit
echo "source /home/renjj/work/tools/gdbplugins/peda/peda.py" >> /root/.gdbinit
echo "source /home/renjj/work/tools/gdbplugins/gdbinit-gef.py" >> /home/renjj/.gdbinit
echo "source /home/renjj/work/tools/gdbplugins/gdbinit-gef.py" >> /root/.gdbinit
echo "source /home/renjj/work/tools/gdbplugins/Gdbinit/gdbinit" >> /home/renjj/.gdbinit
echo "source /home/renjj/work/tools/gdbplugins/Gdbinit/gdbinit" >> /root/.gdbinit

sudo echo "RSAAuthentication yes" >> /etc/ssh/sshd_config
sudo echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config 
sudo echo "AuthorizedKeysFile .ssh/authorized_keys" >> /etc/ssh/sshd_config 
sudo echo "PermitRootLogin yes" >> /etc/ssh/sshd_config 

sudo /usr/sbin/sshd -D

tail -f /dev/null
