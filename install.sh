#!/bin/bash

PWD=`pwd`

sudo apt-get update
# install zsh
sudo apt-get install -y zsh

# install oh-my-zsh
sudo apt-get install -y curl

REMOTE='https://github.com.cnpmjs.org/ohmyzsh/ohmyzsh.git' sh -c "$(curl -fsSL https://raw.staticdn.net/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# 更新子模块
git submodule init
git submodule update

# install thefuck
sudo apt-get install -y python3 python3-pip
sudo pip3 install thefuck

mv ~/.zshrc ~/.zshrc.bak
ln -s $PWD/zsh/zshrc ~/.zshrc
test -e ~/.zsh && rm -rf ~/.zsh.bak && mv ~/.zsh ~/.zsh.bak
ln -s $PWD/zsh/zsh ~/.zsh

# install tmux
sudo apt-get install -y tmux
ln -s $PWD/tmux/tmux.conf ~/.tmux.conf

# install vim
test -e ~/.vim && rm -rf ~/.vim.bak && mv ~/.vim ~/.vim.bak
ln -s $PWD/vim/vim/ ~/.vim
ln -s $PWD/vim/vimrc ~/.vimrc
mkdir ~/.vim/bundle
git clone https://github.com.cnpmjs.org/junegunn/vim-plug.git ~/.vim/bundle/vim-plug --depth=1

# install git
ln -s $PWD/git/gitconfig ~/.gitconfig

# install fzf
git clone --depth 1 https://github.com.cnpmjs.org/junegunn/fzf.git ~/.fzf --depth=1
sed -i 's/github.com/github.com.cnpmjs.org/g' ~/.fzf/install
~/.fzf/install

# handy tools
sudo apt-get install -y htop glances ack-grep ctags cscope finger tree cloc aria2 silversearcher-ag nnn ripgrep axel cowsay axel
# brew install htop glances ctags cscope tree cloc aria2 nnn ripgrep axel cowsay axel
sudo pip3 install ipython jupyter tldr mycli httpie

#npm install -g diff-so-fancy
npm install -g bash-language-server

test -e ~/.dotfiles.bin && rm -rf ~/.dotfiles.bin.bak && mv ~/.dotfiles.bin ~/.dotfiles.bin.bak
ln -s $PWD/bin ~/.dotfiles.bin
