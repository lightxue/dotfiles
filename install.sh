#!/bin/bash

PWD=`pwd`

# install zsh
sudo apt-get install -y zsh

# install oh-my-zsh
sudo apt-get install -y curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# 更新子模块
git submodule init
git submodule update

# install autojump
sudo apt-get install -y autojump
#mkdir tmp
#git clone https://github.com/wting/autojump.git
#cd autojump
#./install.py
#cd ..

# install thefuck
sudo apt-get install -y python3 python3-pip
sudo pip3 install thefuck

mv ~/.zshrc ~/.zshrc.bak
ln -s $PWD/zsh/zshrc ~/.zshrc
ln -s $PWD/zsh/zsh ~/.zsh

# install tmux
sudo apt-get install -y tmux
ln -s $PWD/tmux/tmux.conf ~/.tmux.conf

# install vim
ln -s $PWD/vim/vim/ ~/.vim
ln -s $PWD/vim/vimrc ~/.vimrc
# 改用zsh的vundle插件升级

# install git
ln -s $PWD/git/gitconfig ~/.gitconfig

# handy tools
sudo apt-get install -y htop glances ack-grep httpie ctags cscope finger tree cloc aria2
sudo pip3 install ipython jupyter tldr

# install bat
