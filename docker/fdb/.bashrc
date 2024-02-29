
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
source /opt/rh/devtoolset-10/enable
source /opt/rh/rh-python38/enable
source /opt/rh/rh-ruby27/enable
export CC=/opt/rh/devtoolset-10/root/bin/gcc
export CXX=/opt/rh/devtoolset-10/root/bin/g++

# --------------------------------------------------
# PS1 format
# time
PS1='\[\033[00m\][\t] '

PS1=$PS1'\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;32m\]\h\[\033[00m\]'

# working directory
PS1=$PS1':\[\033[01;36m\]\w\[\033[00m\]'

# last command status
export PS1=$PS1'\n\[\033[01;05m\]\$ \[\033[00m\]' # UID symbol
