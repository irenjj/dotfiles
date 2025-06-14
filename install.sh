#! /bin/bash

brew install ripgrep fd bat exa fzf llvm nvim

cargo install exa

CONF_DIR="$( cd "$( dirname "$0" )" && pwd )"

# bash
unlink ${HOME}/.bash_profile
unlink ${HOME}/.bashrc
ln -s ${CONF_DIR}/bash/.bash_profile ${HOME}/.bash_profile
ln -s ${CONF_DIR}/bash/.bashrc ${HOME}/.bashrc

# tmux
unlink ${HOME}/.tmux.conf
ln -s ${CONF_DIR}/tmux/.tmux.conf ${HOME}/.tmux.conf

# lldb
unlink ${HOME}/.lldbinit
ln -s ${CONF_DIR}/lldb/.lldbinit ${HOME}/.lldbinit

# nvim
unlink ${HOME}/.config/nvim
ln -s ${CONF_DIR}/nvim ${HOME}/.config/nvim

# kitty
unlink ${HOME}/.config/kitty
ln -s ${CONF_DIR}/kitty ${HOME}/.config/kitty
