#!/bin/bash

PWD=`pwd`

# install zsh
sudo apt-get install zsh

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install autojump
mkdir tmp
git clone https://github.com/wting/autojump.git
cd autojump
./install.py
cd ..

mv ~/.zshrc ~/.zshrc.bak
ln -s $PWD/zsh/zshrc ~/.zshrc

# install tmux
sudo apt-get install tmux
ln -s $PWD/tmux/tmux.conf ~/.tmux.conf

# install vim
ln -s $PWD/vim/vim ~/.vim
ln -s $PWD/vim/vimrc ~/.vimrc
# submodule for vundle
mkdir vim/vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git vim/vim/bundle/Vundle.vim
# vim +PluginInstall +qall

# install git
ln -s $PWD/git/gitconfig ~/.gitconfig
