#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y

# install zsh
sudo apt-get install -y zsh
# install oh-my-zsh and set zsh as default shell
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" <<< "Y"

# install postgresql
sudo apt install -y postgresql postgresql-contrib

# install mysql
sudo apt install -y mysql-server

# install redis
sudo apt install -y redis-server


# install go
sudo rm -rf /usr/local/go
curl -L https://golang.org/dl/go1.16.5.linux-amd64.tar.gz --output /tmp/go1.16.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf /tmp/go1.16.5.linux-amd64.tar.gz
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.zshrc

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
