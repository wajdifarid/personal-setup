#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y

# install zsh and oh-my-zsh
sudo apt-get install -y zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# set zsh as default shell
chsh -s $(which zsh)

# install node.JS
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
sudo apt-get install -y nodejs

# install postgresql
sudo apt-get install -y postgresql

# install mysql
sudo apt install mysql-server

# add windows repository shortcut and set is as default path when opening terminal
echo \
"
# wr evaluates to the absolute path to your Windows user's root.
export wr=/c/Users/farid/Documents

# This gives us a quick way of moving directly to the Windows root
alias cdwr='cd \$wr'

# This brings you to your Windows Working directory immediatly when you open a new terminal.
cdwr
" >> ~/.zshrc

# remove downloaded package installer
sudo apt autoremove -y

echo "Restart your computer to avoid any error with docker"
