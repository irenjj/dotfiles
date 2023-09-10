#!/bin/bash

sudo sysctl -w vm.max_map_count=2000000

echo "export PATH="/var/local/ldb-toolchain/bin":$PATH
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
export PATH=$JAVA_HOME/bin:$PATH
export DORIS_HOME=/home/renjj/open-src/doris" >> ~/.bashrc
echo "PS1='\[\e[37;40m\][\[\e[32;40m\]\u\[\e[37;40m\]@\h \[\e[36;40m\]\W\[\e[0m\]]\\$ '" >> ~/.bashrc
source ~/.bashrc

#sudo chown -R renjj:renjj /home/renjj/open-src

tail -f /dev/null
