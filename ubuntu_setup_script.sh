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

# install docker and kubernetes
# Install Docker's package dependencies.
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
    
# Download and add Docker's official public PGP key.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Verify the fingerprint.
sudo apt-key fingerprint 0EBFCD88

# Add the `stable` channel's Docker upstream repository.
#
# If you want to live on the edge, you can change "stable" below to "test" or
# "nightly". I highly recommend sticking with stable!
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Update the apt package list (for the new apt repo).
sudo apt-get update -y

# Install the latest version of Docker CE.
sudo apt-get install -y docker-ce

# Allow your user to access the Docker CLI without needing root access.
sudo usermod -aG docker $USER

# Install Docker Compose into your user's home directory.
pip install docker-compose --user

# Configure WSL to Connect to Docker for Windows
echo "export DOCKER_HOST=tcp://localhost:2375" >> ~/.zshrc && source ~/.zshrc

# make c drive accesible to docker (your windows directory will be moved from /mnt/c into /c)
sudo bash -c 'echo \
"[automount]
root = /
options = \"metadata\"
" >> /etc/wsl.conf'

# Install kubernetes
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - 
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

# symlink your Windows kube config to WSL
mkdir ~/.kube
ln -s /c/Users/farid/.kube/config ~/.kube/config

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
