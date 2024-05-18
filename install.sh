#! /bin/bash

CONF_DIR="$( cd "$( dirname "$0" )" && pwd )"

# bash
unlink ${HOME}/.bash_profile
unlink ${HOME}/.bashrc
ln -s ${CONF_DIR}/bash/.bash_profile ${HOME}/.bash_profile
ln -s ${CONF_DIR}/bash/.bashrc ${HOME}/.bashrc

# git 
# mv ${HOME}/.gitconfig ${HOME}/.gitconfig.bak
# mv ${HOME}/.gitignore_global ${HOME}/.gitignore_global.bak
# cp ${CONF_DIR}/git/.gitconfig ${HOEM}/.gitconfig
# cp ${CONF_DIR}/git/.gitignore_global ${HOEM}/.gitignore_global

# tmux
unlink ${HOME}/.tmux.conf
ln -s ${CONF_DIR}/tmux/.tmux.conf ${HOME}/.tmux.conf

# lldb
unlink ${HOME}/.lldbinit
ln -s ${CONF_DIR}/lldb/.lldbinit ${HOME}/.lldbinit

# alacritty
unlink ${HOME}/.config/alacritty
ln -s ${CONF_DIR}/alacritty ${HOME}/.config/alacritty

# nvim
unlink ${HOME}/.config/nvim
ln -s ${CONF_DIR}/nvim ${HOME}/.config/nvim

# vim
unlink ${HOME}/.vimrc
ln -s ${CONF_DIR}/vim/.vimrc ${HOME}/.vimrc

# zellij
unlink ${HOME}/.config/zellij
ln -s ${CONF_DIR}/zellij ${HOME}/.config/zellij
