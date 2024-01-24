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

# zsh
rm -rf ${HOME}/.oh-my-zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git ${HOME}/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${HOME}/.oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${HOME}/.oh-my-zsh/plugins/zsh-syntax-highlighting
unlink ${HOME}/.zshrc
unlink ${HOME}/.zshenv
ln -s ${CONF_DIR}/zsh/.zshrc ${HOME}/.zshrc
ln -s ${CONF_DIR}/zsh/.zshenv ${HOME}/.zshenv
