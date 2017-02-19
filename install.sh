#!/bin/bash

PWD=`pwd`

# install zsh
apt-get install zsh

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install autojump
mkdir tmp
git clone https://github.com/wting/autojump.git
cd autojump
./install.py

mv ~/.zshrc ~/.zshrc.bak
ln -s $PWD/zsh/zhsrc ~/.zshrc

# install tmux
apt-get install tmux
ln -s $PWD/tmux/tmux.conf ~/.tmux.conf

# install vim
ln -s $PWD/vim/vim ~/.vim
ln -s $PWD/vim/vimrc ~/.vimrc
# submodule for vundle
# vim +PluginInstall +qall
