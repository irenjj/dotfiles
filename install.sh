#! /bin/bash

mv ${HOME}/.bash_profile ${HOME}/.bash_profile.bak
mv ${HOME}/.bashrc ${HOME}/.bashrc.bak
#mv ${HOME}/.gitconfig ${HOME}/.gitconfig.bak
mv ${HOME}/.tmux.conf ${HOME}/.tmux.conf.bak
mv ${HOME}/.lldbinit ${HOME}/.lldbinit.bak


CONF_DIR="$( cd "$( dirname "$0" )" && pwd )"

ln -s ${CONF_DIR}/bash/.bash_profile ${HOME}/.bash_profile
ln -s ${CONF_DIR}/bash/.bashrc ${HOME}/.bashrc
ln -s ${CONF_DIR}/tmux/.tmux.conf ${HOME}/.tmux.conf
ln -s ${CONF_DIR}/lldb/.lldbinit ${HOME}/.lldbinit

